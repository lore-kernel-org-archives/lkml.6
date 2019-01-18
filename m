Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D212086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epJq4JMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfARHqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:46:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:46:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so5987270plb.5;
        Thu, 17 Jan 2019 23:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ang6ET/R+hbftXzYXvaG21d4pCzC6D1zSB0VrSEsuQE=;
        b=epJq4JMK8mC2NZFTU0R9befHNmXq4BPuflg7OYUUnB8rBXIbvL6KmJcjFS5VeSvVb5
         DNFtJLvXsnIs0jO5hz0NKkaozWKORMyGTVDZP8rLgP8VnISUQ9RuEOHo/EFE+vfZD4Ip
         YvFxmyE1NaXVjAxyzZ+bW9iHp86XrVTBw0Hgfn+g7W7b/EsJyHY8CfM/1IsEMJltp/Jc
         CD/NyumxmXG8CpRtnRMzXG6e98CT8WkUiqaRnaUED7a68Dffn//Ypof2M01XcRJv/ROL
         WBgjUQP57BgvxAcSC3D915JJtJgfkLkvEPYN+MK1er2V0OuQSFHaWiEFXDbmo9ipXkNn
         1Cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ang6ET/R+hbftXzYXvaG21d4pCzC6D1zSB0VrSEsuQE=;
        b=n7Dr6hffEqDuFtM+Px7DemIWVVetv3miz0qW8ZmJcCSUtqKwMyMjIkIx0la5grLe+a
         8Tae0bRkejSVvHwou0Tz7xp2GYfdmiN2COPsqRFv90x674uu15q9XiPSXxTsvkCfA3hF
         QXDw/f8fffSlizqQPfaSwj0xJBwl8QvUqazsqRt9tu+sHfDh4SCLJ94UJ+Pq8sDnN3ve
         Qrs/KbzOHvXqZkoI99cducSNMc2fp6tTlg5CpA2buG8phigDzQKHrH+iBT78DVEAhD3H
         4OkTTBFSvX+zmA0ybIiNghx+UXBT3DVFR6CJuE6eWJkpEvNTY4gNP9vLnhQKivV0kRSe
         Ugig==
X-Gm-Message-State: AJcUukcCOLAFviSThJV7U7lQ9WV1amQdsyUKA0OJHtxedB3yxz7TIljo
        rfagkDHfgYG1M770fJJCsSo=
X-Google-Smtp-Source: ALg8bN4c04rSR3VsexP65f7Yso1GX5iwAK4o29CDlMctHqGDnJY+fK5f82IPD4WDhmHDhXgtY0cdNw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr18412982plr.89.1547797589038;
        Thu, 17 Jan 2019 23:46:29 -0800 (PST)
Received: from [192.168.42.184] ([103.44.164.150])
        by smtp.gmail.com with ESMTPSA id t12sm5755925pfi.45.2019.01.17.23.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:46:28 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw, Chris Brandt <chris.brandt@renesas.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <8367577a-9717-92e3-cbc8-8dee52876bcb@gmail.com>
 <OF914E6438.79205FE6-ON48258386.002973E8-48258386.002A41F0@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <16bdae9c-bdef-b8eb-73e9-85bc8e724f20@gmail.com>
Date:   Fri, 18 Jan 2019 08:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <OF914E6438.79205FE6-ON48258386.002973E8-48258386.002A41F0@mxic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 8:41 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/18 下午 03:10
>>
>> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> > +----------------------------------------------------------
>> > +
>> > +Required properties:
>> > +- compatible: should be "renesas,rcar-gen3-rpc"
>> > +- #address-cells: should be 1
>> > +- #size-cells: should be 0
>> > +- reg: should contain three register areas:
>> > +   first for the base address of rpc-if registers,
>> > +   second for the direct mapping read mode and
>> > +   third for the write buffer area.
>> > +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> > +- clock-names: should contain "rpc"
>> > +- clocks: should contain 1 entries for the module's clock
>> > +
>> > +Example:
>> > +
>> > +   rpc: rpc@ee200000 {
>> > +      compatible = "renesas,rcar-gen3-rpc";
>> > +      reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
>>
>> 0x7fff should be 0x8000 , right ?
> 
> RPC write buffer starts at 0xee208000 w/ 256 bytes size.

The size of the RPC-IF block is 0x8000 though, is it not ?

>> > +            <0 0xee208000 0 0x100>;
>>
>> Isn't the write buffer part of the RPC-IF register set ?
> 
> yep, but by Sergei and Geert's comments, we use a separate reg entry
> for this write buffer.
> ---- copy the replied email from Geert ---------------------------------
>> Maybe Geert or Marek could comment on it, thanks.
> 
> Given the writer buffer is separate from the other registers (it's in
> a different
> 4 KiB page, and thus may be at a different offset on future SoCs), and not
> present on RZ/A1, I think it's a good idea to use a separate reg entry
> for it.
> -----------------------------------------------------------------------

+CC Chris, the RZ/A1 has no write buffer for the RPC ?

-- 
Best regards,
Marek Vasut
