Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD46C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DD420834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQyIbIWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DD420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeJFBxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:53:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38536 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeJFBxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:53:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so2622988pff.5;
        Fri, 05 Oct 2018 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ghk/Vg/V7vqswhgv++QqPn2eTXQmOf4Jw4JSP1UZmIg=;
        b=hQyIbIWaCQF7mI/FUakxhjXbWrPeFxSFY5U1Xz13cC4z57F1vusu6AM31FTuKyZ57c
         gqItLWA1LYy5XIU/Xnaw8SzQHsI3JganDf9FWgLZipeO9xu/Ts2uqa1QP77Zcxr5YOkL
         6oylO1X9+2wKsVmS+2Tgjv3twyEk0iOLPFE5Vk6P3MFZlZupbRWUXEiSi/+YCp4vmU3g
         m92LPs5tAcXD3NU+M0d3WAp9f3yodRyCCxoc9tdnz/uAxooj+4dbsDBXK9LKGpPneP17
         8rUSvkw9JU3fG7fb5sRL1CShil71wU8E8ktQ47M+MZprkxEWrxH1PEoWw2O7YbI0a3sE
         zrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ghk/Vg/V7vqswhgv++QqPn2eTXQmOf4Jw4JSP1UZmIg=;
        b=CYWWgkl2QE5y3y6mjD5scUm2A/qmBWGVUnpsO38CixKzVbQNoFFr6fpt4dfQwxeAht
         3XPyYb8Y+OFq0wk8ScosWMaLdPkvuddZu+OphWiiKFDprYQ2jZECJ04weSgYVQ9LLprx
         ocLmgUfiXOzv+rxmzOx/Ys79xftkfYnxvvgM2QOJbSfOl+9yHV9tNTzbBIYzFol+CorD
         y/jLaQ5noo0ThXtyQ2dwfHggc4SA0la86KcOsccKWbWS/KXP+5VvyPcNldUafa3pCt3x
         hb1UUeSR2lISzrXXwC1hczCUIS/S5PzQIev8nems4/tB307SUk0O5C3i2sDIOXVKtU39
         lo7g==
X-Gm-Message-State: ABuFfoiawFl7AU4IWYIf/WhbXPPhwZkWX9XFPwF4/g3f6F/bbgh0Ku8w
        u6hKeqtoqQNPXvKZdIQwfC0=
X-Google-Smtp-Source: ACcGV62rVsZEojQh1DkNJ/f9gUcGjTdHHgWK05PWh5fTIYYLqbwJjApJLszxwWMSeOywvFtvJ1unBw==
X-Received: by 2002:a62:c08b:: with SMTP id g11-v6mr13303728pfk.72.1538765627852;
        Fri, 05 Oct 2018 11:53:47 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j75-v6sm11711334pfk.125.2018.10.05.11.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 11:53:47 -0700 (PDT)
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f39a84d3-f706-d31e-db22-4e3ebc72c447@gmail.com>
Date:   Fri, 5 Oct 2018 11:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKK3f4W1DdPkzNed0=tx5Oxu9w=RKs8PnaXMfuShBpV1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/18 08:07, Rob Herring wrote:
> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> If overlay properties #address-cells or #size-cells are already in
>> the live devicetree for any given node, then the values in the
>> overlay must match the values in the live tree.
>>
>> If the properties are already in the live tree then there is no
>> need to create a changeset entry to add them since they must
>> have the same value.  This reduces the memory used by the
>> changeset and eliminates a possible memory leak.  This is
>> verified by 12 fewer warnings during the devicetree unittest,
>> as the possible memory leak warnings about #address-cells and
> 
> and...?

#size-cells no longer occur.

(Thanks for catching that.)


>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 29c33a5c533f..e6fb3ffe9d93 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>   * @target may be either in the live devicetree or in a new subtree that
>>   * is contained in the changeset.
>>   *
>> - * Some special properties are not updated (no error returned).
>> + * Some special properties are not added or updated (no error returned):
>> + * "name", "phandle", "linux,phandle".
>> + *
>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>> + * are already in the live tree, but if present in the live tree, the values
>> + * in the overlay must match the values in the live tree.
> 
> Perhaps this should be generalized to apply to any property? We can't
> really deal with property values changing on the fly anyways.

That is a bigger discussion.  I'd prefer to not hold up this series for that
question to be resolved.  It will be easy enough to generalize in an add-on
patch later.


>>   *
>>   * Update of property in symbols node is not allowed.
>>   *
>> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>  {
>>         struct property *new_prop = NULL, *prop;
>>         int ret = 0;
>> +       bool check_for_non_overlay_node = false;
>>
>>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>>             !of_prop_cmp(overlay_prop->name, "phandle") ||
>> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>         if (!new_prop)
>>                 return -ENOMEM;
>>
>> -       if (!prop)
>> +       if (!prop) {
>> +
> 
> Remove the extra blank lines.

Will do.

> 
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>                                                 new_prop);
>> -       else
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> 
> Technically these are __be32 types. This could use a helper (of_prop_val_eq).

These are in a unpacked form, so cpu byte order, not FDT byte order.

> 
> I'm not sure we really need to validate the length here as dtc does
> that (but yes, not everything is from dtc).

Since I'm accessing 4 bytes of the values, I need to be sure the lengths
are at least 4.  For #address-cells and #size-cells the property is
specified as four bytes, so I could simplify the code for the specific case.

If this gets extended to any arbitrary property then a new of_prop_val_eq()
would check that the lengths are equal and the values (of size length) are
also equal.


> 
>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>> +                              target->np);
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>> +                              target->np);
>> +
>> +       } else {
>> +
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>>                                                    new_prop);
>>
>> +       }
>> +
>> +       if (check_for_non_overlay_node &&
>> +           !of_node_check_flag(target->np, OF_OVERLAY))
>> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
>> +                      __func__, target->np, new_prop->name);
>> +
>>         if (ret) {
>>                 kfree(new_prop->name);
>>                 kfree(new_prop->value);
>> --
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

