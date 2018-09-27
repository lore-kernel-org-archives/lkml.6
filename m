Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479C22156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3Xc2tN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479C22156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeI0OMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:12:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38485 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeI0OMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:12:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id x8-v6so4186780eds.5;
        Thu, 27 Sep 2018 00:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPpYznAj87DPVzlW6kNndkK3D9Uz+Fy28fCyfcBw0VM=;
        b=n3Xc2tN7Lx0dERyjHNQ1nesr467135Mb4UuUvTnL2ay+ZUEW+TnTsYrh3fkXJQqz/3
         t05enBTldqSGGftj55nZNg4TjAQRi8eKZMYtQKSaMcb77fTTnZGO5YJqCwLzeJDr9sD+
         ZWkVuRWCZt33I3+jWdCULu3KJECPhQpOWDBLTg50vxa/C3TPMAdAHeAHJ5MEiDtXuetC
         4o0eazNIlVR2EHr9JmJhlWRPlGGGYCgXuMuEt9jnA368smFGDuqCg5w6VyzX3cR0LsIy
         rNJTcJ9DbOmGPofV0ulVHsTpxE2+XqhXW+a3Gb+p6cjU/k/QsJCCUazyjN7DclRJW0rX
         aqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GPpYznAj87DPVzlW6kNndkK3D9Uz+Fy28fCyfcBw0VM=;
        b=BSHFR97c5CWDyl8YEtfLiwtTlLkVsaan5kHjwaoC9N3K8mFyxL+z9Sj5nZafLRRSvg
         5VYjNZ5CxHCh21hUsTCZuStVx7/EJTu53TiAmbc5Fg0XtD2G3AybllVGc6pCxeFj038Z
         x4fDp+LHxkWDQhrMgicaPmc0uvplOgUBmHEaVQkGNgodkEBKLvOV758u5tB+qXnJCX17
         xLBz578IY3gQMye5uzgMwPCf5CCbKhgFNu+bVBrF+P2yTwIlCIwtXtfeF31KiprPh/uJ
         tmPMgswJLUJDJfCtW/aRk8W7hHWD6uJdmIqJ3tny7I9E6EPudjXOfkfKUvPiyLGpG6rM
         RJ7Q==
X-Gm-Message-State: ABuFfojEGN5VyumnasO977G/eMaotomRXu2R4T10DoJOCvOEc+NdsCWw
        m6nKzq5faP7jZq5iPTFK2ig=
X-Google-Smtp-Source: ACcGV603Ec75Ss9gUEoLix3GTbyZZPanRelXvJTSX7PrPwj7fUJwVAWSdS8x4n5o9G7AobUZvgl9+g==
X-Received: by 2002:a50:9ac5:: with SMTP id p63-v6mr17097101edb.112.1538034902840;
        Thu, 27 Sep 2018 00:55:02 -0700 (PDT)
Received: from ziggy.stardust ([93.176.144.101])
        by smtp.gmail.com with ESMTPSA id j14-v6sm847911edq.25.2018.09.27.00.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 00:55:01 -0700 (PDT)
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
To:     houlong wei <houlong.wei@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <Bibby.Hsieh@mediatek.com>,
        =?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
        =?UTF-8?B?RGFveXVhbiBIdWFuZyAo6buD6YGT5Y6fKQ==?= 
        <Daoyuan.Huang@mediatek.com>,
        =?UTF-8?B?SmlhZ3VhbmcgWmhhbmcgKOW8oOWKoOW5vyk=?= 
        <Jiaguang.Zhang@mediatek.com>,
        =?UTF-8?B?RGVubmlzLVlDIEhzaWVoICjorJ3lroflk7Ip?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        =?UTF-8?B?TW9uaWNhIFdhbmcgKOeOi+Wtn+Wptyk=?= 
        <monica.wang@mediatek.com>,
        =?UTF-8?B?SHMgTGlhbyAo5buW5a6P56WlKQ==?= <Hs.Liao@mediatek.com>,
        =?UTF-8?B?R2lubnkgQ2hlbiAo6Zmz5rK75YKRKQ==?= 
        <ginny.chen@mediatek.com>,
        =?UTF-8?B?RW56aHUgV2FuZyAo546L5oGp5p+xKQ==?= 
        <enzhu.wang@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
 <1534297570.21668.3.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <23d76d03-c0e9-cd83-f9a8-f5efa0c72938@gmail.com>
Date:   Thu, 27 Sep 2018 09:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1534297570.21668.3.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/08/2018 03:46, houlong wei wrote:
[...]
>> +
>> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>> +				   u32 arg_a, u32 arg_b)
>> +{
>> +	u64 *cmd_ptr;
>> +
>> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
>> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
>> +		return -ENOMEM;
>> +	}
>> +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
>> +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
>> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
>> +{
>> +	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
>> +		    (subsys << CMDQ_SUBSYS_SHIFT);
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_write);
>> +
>> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
>> +			u32 subsys, u32 offset, u32 mask)
>> +{
>> +	u32 offset_mask = offset;
>> +	int err;
>> +
>> +	if (mask != 0xffffffff) {
>> +		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
>> +		WARN_ON(err < 0);

If we want to write out a warning to the kernel log, then we should but that in
the if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) from
cmdq_pkt_append_command to make it consistent between cmdq_pkt_write,
cmdq_pkt_write_mask and cmdq_pkt_finalize

Sorry, just saw this right now.

>> +		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
>> +	}
>> +
>> +	return cmdq_pkt_write(pkt, value, subsys, offset_mask);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_write_mask);
>> +
>> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
>> +{
>> +	u32 arg_b;
>> +
>> +	if (event >= CMDQ_MAX_EVENT)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * WFE arg_b
>> +	 * bit 0-11: wait value
>> +	 * bit 15: 1 - wait, 0 - no wait
>> +	 * bit 16-27: update value
>> +	 * bit 31: 1 - update, 0 - no update
>> +	 */
>> +	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_wfe);
>> +
>> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
>> +{
>> +	if (event >= CMDQ_MAX_EVENT)
>> +		return -EINVAL;
>> +
>> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
>> +				       CMDQ_WFE_UPDATE);
>> +}
>> +EXPORT_SYMBOL(cmdq_pkt_clear_event);
>> +
>> +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>> +{
>> +	int err;
>> +
>> +	/* insert EOC and generate IRQ for each command iteration */
>> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
>> +	WARN_ON(err < 0);

Should move into cmdq_pkt_append_command

>> +
>> +	/* JUMP to end */
>> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
>> +	WARN_ON(err < 0);

same here.

>> +
>> +	return err;
>> +}
>> +
[...]

Regards,
Matthias
