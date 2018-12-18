Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3904C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B4F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlQifCRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeLRUdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:33:21 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45206 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeLRUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:33:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8647429pfd.12;
        Tue, 18 Dec 2018 12:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zreIIbL+3MU68nvyzHBRLGe/WzUlqPgB+0qC4jO7Klg=;
        b=qlQifCRxQf01GN5Fl+wjIEsJX8MdYfgOLDuaB0lUlyc3d+ltm4uDT5zJ7HZhLhlPoQ
         amVN/58vNcRu9TWV+gNOGk09m8dIhQOEDXuJOzI3/Fet9Ida3J/6cO0hwI19lurDG3lZ
         TlMXQ7GlN9IbSdZxt8Xv4TEtsXHNKoGySoLn6f7rv+MmC8BqYiYVqeVe1l94kqJR+gBU
         zLfGNCe3D5FQg6Sy6BncgacitVDhzfdjf3zdMnGPwudBePVwFWooK2h/HybedQclpyFl
         JPPRSclanRwgnm9/taguO/69oTdyJqOJi6WyZkzdR0JMiE7Q6e2fEF6hsJzGKCyjo2Wl
         I//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zreIIbL+3MU68nvyzHBRLGe/WzUlqPgB+0qC4jO7Klg=;
        b=OdcuMAjoDECEorw8gyxkg3W9nz4MApxpBL0RsuBQo1aLoz35CfOzVxbXUsZE3TPHzP
         ey3uJu3lGOw3MPsyBRkXM7H/Sm6lgUm9rxLW+0QvT9tZSpVA9R2X/1GfHsY9paiMRIi1
         aowlxASGH7oE4intzdfbZjeLuppu//tZTvHLGc90DsByEMheltzXeOKHjdr3pvRxfSBR
         n1l8o+BIEfC69uevmkNFoallT7OT4Z7Wk2H529VoEPMZMi8jfwKGrx1hsPNkMYETZrrZ
         fmx912fyxEwmAObD7pU+zY08470ThiTtU0RsN2y09DoxXvkipdQRclgfVd8UdrhkkJXz
         aScw==
X-Gm-Message-State: AA+aEWZu4s5rWYi9t54bG8kXKX0j6ZRtYv9w4tm/y0Q2rPRKc0WmohWP
        Pe43fWgvI4XOBVGBqh0z0F0=
X-Google-Smtp-Source: AFSGD/X/hsJAIpS/yYvmfQSfaOlsru/WUTfRbk2Xhs8s11grPBRPdt2Kwk2kuSwhUfrsw2HLwoC5nw==
X-Received: by 2002:a63:4665:: with SMTP id v37mr577436pgk.425.1545165200203;
        Tue, 18 Dec 2018 12:33:20 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n66sm23909508pfk.19.2018.12.18.12.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 12:33:19 -0800 (PST)
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
 <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
 <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
 <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
Message-ID: <6b6a3d11-e60a-f55c-04fa-deafdd58ccec@gmail.com>
Date:   Tue, 18 Dec 2018 12:33:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 12:09 PM, Frank Rowand wrote:
> On 12/18/18 12:01 PM, Rob Herring wrote:
>> On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 12/17/18 2:52 AM, Michael Ellerman wrote:
>>>> Hi Frank,
>>>>
>>>> frowand.list@gmail.com writes:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> Non-overlay dynamic devicetree node removal may leave the node in
>>>>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>>>>> will incorrectly find the stale entry.  Remove the node from the
>>>>> cache.
>>>>>
>>>>> Add paranoia checks in of_find_node_by_phandle() as a second level
>>>>> of defense (do not return cached node if detached, do not add node
>>>>> to cache if detached).
>>>>>
>>>>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>>> ---
>>>>
>>>> Similarly here can we add:
>>>>
>>>> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>>>
>>> Yes, thanks.
>>>
>>>
>>>> Cc: stable@vger.kernel.org # v4.17+
>>>
>>> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
>>> fix).  So the bug will not be in stable.
>>
>> 0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
>> Annotating it with 4.17 only saves Greg from trying and then emailing
>> us to backport this patch as it wouldn't apply.
> 
> Thanks for the correction.  I was both under-thinking and over-thinking,
> ending up with an incorrect answer.
> 
> Can you add the Cc: to version 3 patch comments (both 1/2 and 2/2) or do
> you want me to re-spin?

Now that my thinking has been straightened out, a little bit more checking
for the other pre-requisite patches show:

  v4.18: commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  v4.19: commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")

These can be addressed by changing the "Cc:" to ... # v4.19+
because stable v4.17.* and v4.18.* are end of life.

Or the pre-requisites can be listed:

   # v4.17: b9952b5218ad of: overlay: update phandle cache
   # v4.17: e54192b48da7 of: fix phandle cache creation
   # v4.17

   # v4.18: e54192b48da7 of: fix phandle cache creation
   # v4.18

   # v4.19+

Do you have a preference?

-Frank
> 
> -Frank
> 
>>
>> Rob
>>
> 
> 

