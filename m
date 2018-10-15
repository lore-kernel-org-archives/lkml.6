Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A0120645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG5xK6o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A0120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJPDQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:16:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40861 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeJPDQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:16:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so3184710pfi.7;
        Mon, 15 Oct 2018 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=txs08WYIQldNuSxsaJcvv7BGm6c3Ca6Y9k3ss7JzIpk=;
        b=eG5xK6o7Qi3i2C02Ow7uOTNgscIeoDf1ygA3c2Wd5NzemriGEcMe2s/ZrOiOTuBh/9
         Q+TR/0y82oz0Yb3hrHgGCH3lXkElwqu2WEJqV0+gg+9SQMvQsf19PGC0W7YuPdd7OuNa
         M1+9LGvoWXufhw33MKagu+9wwHmUNVcyZXiv9IdiYSkkA2rzI0AOJMF9i76pj0g5W55w
         CR3L4VE9wIwaXW2Vv5VSMp0GNl7Rs+0bKKea4eeXKmWk0zHvsWDjABN88I2ipINhq/Xs
         +17WluOtUFsc/ME8FIGO8P5k1BJlfSnJYq94tYiYV4sg7aWU9dpEBVIAdMnHQn++/A7o
         fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=txs08WYIQldNuSxsaJcvv7BGm6c3Ca6Y9k3ss7JzIpk=;
        b=CuFrpPYdCFTBRwkuHSdOJjcg1mz/zWalQg0MxTxsV14UyNG3lotg0Ett0Nv54mxiGT
         RIBlBDCJzaisxAkXCEwwygm1XdLTyDS9brLeVK9wHm9QAqnx7QpRPPt1VsCVwINDNIoP
         tZJj95LYB3fHZhXkTSjjA70HJ5xut+RYEW4sD79sAivAJIfIsTjmMOlnYfm8OJXdOkhY
         0wHDchgEv9C5gWOGl5QVqIBtFrLyxj11gazy3nmuv33u4JKpJkP6uYCbbmEUUj2IApF5
         nCGGBrkgSPBVOhaTR0kH/7K8W7yaqavmYT30jl2ztT6QpNHBUpyIKuZncGgWLtHNE171
         KuRw==
X-Gm-Message-State: ABuFfoh7AojUTXytlwzYqldBDi/atUFHfT9lAVRj6rdUMrWoTYvBJia/
        UXXSnIJBr1gzse6A3AnlynQ=
X-Google-Smtp-Source: ACcGV61vKAmZkHDZIt5EegVYVDuoF5zWvgrjGdX41VfDHrb/akBxa8lQQqC+xsTkIOOPkyZUzkXrgQ==
X-Received: by 2002:a62:4681:: with SMTP id o1-v6mr18721802pfi.108.1539631813699;
        Mon, 15 Oct 2018 12:30:13 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c21-v6sm23955309pfe.93.2018.10.15.12.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:30:13 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] of: overlay: check prevents multiple fragments
 touching same property
From:   Frank Rowand <frowand.list@gmail.com>
To:     Joe Perches <joe@perches.com>, Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-14-git-send-email-frowand.list@gmail.com>
 <b6ee53f7e02cc3ea52713ae82402e97d7050cb3e.camel@perches.com>
 <850f0866-1189-5a49-01c5-79caf270abbd@gmail.com>
 <16f48648393366d91e43cd66b3d0a346b1ed29ab.camel@perches.com>
 <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
Message-ID: <f7797d5b-7b9c-5279-b388-31c7a01f48d1@gmail.com>
Date:   Mon, 15 Oct 2018 12:30:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e045d69a-7896-3ff1-8472-2f51c2468d7f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/18 20:21, Frank Rowand wrote:
> On 10/14/18 18:55, Joe Perches wrote:
>> On Sun, 2018-10-14 at 18:52 -0700, Frank Rowand wrote:
>>> On 10/14/18 18:06, Joe Perches wrote:
>>>> On Sun, 2018-10-14 at 17:24 -0700, frowand.list@gmail.com wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Add test case of two fragments updating the same property.  After
>>>>> adding the test case, the system hangs at end of boot, after
>>>>> after slub stack dumps from kfree() in crypto modprobe code.
>> []
>>>> I think this is worse performance than before.
>>>>
>>>> This now walks all entries when before it would
>>>> return -EINVAL directly when it found a match.
>>>
>>> Yes, it is worse performance, but that is OK.
>>>
>>> This is a check that is done when a devicetree overlay is applied.
>>> If an error occurs then that means that the overlay was incorrectly
>>> specified.  The file drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>>> in this patch provides an example of how a bad overlay can be created.
>>>
>>> Once an error was detected, the check could return immediately, or it
>>> could continue to give a complete list of detected errors.  I chose to
>>> give the complete list of detected errors.
>>
>> Swell.  Please describe that in the commit message.
> 
> If a version 4 of the series is created I will update the commit
> message.  As a stand alone item I do not think it is worth a
> new version.

And there will be a version 4, so I will update the commit message.

-Frank
