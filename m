Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A09C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED97208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5yQJjPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED97208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJPEDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:03:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36915 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeJPEDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:03:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id u6-v6so7090386plz.4;
        Mon, 15 Oct 2018 13:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jm8fB0wVC8YkHOkSv8uX8/TXjvy9fnL7cXDYSdXQAck=;
        b=X5yQJjPP+pBY4TQoG/W/D39i8UVBjJFM2qB0+9jgztrjoGjQrUEd0T2NqHQPodx+WI
         ngBOG0/inIIoQKpmT2A5Fyw89GEoj2R6l8coBQQReq/StzGX6M3Dc+au1nPsWOtgeBpK
         ISGEGJEycZWpJtE/dSen1PVw1wF7JaKLJ+99U4XI61CrqWRaW4cutVHChAE9Ar+h1AyN
         stCSMNA/lUSUojQnQnOUyzBTbdyP4MEXGzaWjsw6WzVh6WL5WzxJ4m619GVMrFWLjZtR
         AlluUUuLucdaN8mgswCcU0k0RMa9lPToBzRCTcPGW6aeSiU62+OS5pXgBaKOr+0IE5ER
         GtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jm8fB0wVC8YkHOkSv8uX8/TXjvy9fnL7cXDYSdXQAck=;
        b=Kt1Bqn9nifKE9mliiK2xFvsMEbTKndkNKIeTSaWZxZgyHqInICJaKrGxizZzDN3Hw5
         iuvqbPEunjdJF1q1OXKF5DsMYk7ChceJb5y2o6dmco23Zy02EnZGqz5UmLVI1QdFu6Tl
         VWkXmzu4Zd1MSKEOGtCjmji2HYc9qaKi+OXOza7pRWXbNftF3yiWOB9uWJED9xhB+Pq9
         2bMpLNBwyGNRDiX8OtE43NY/37/XbVolKVSGoKdtyFmhJlVwVUMfop8Sn7WyIVUDC0ca
         wOyZKH+v+sm7dgW5dztAhaZhQXqKpA3tc10ND+CBo+K58x1Q3u1cI9/LwV9wPeXCMv/C
         Pc2g==
X-Gm-Message-State: ABuFfogvywKrwoCCrEKLy2+0tQnzcvoNRI1qVJNuQv/aIE9Yg+glrG30
        rnYoV0o8y5C6vbF73cvV2hk=
X-Google-Smtp-Source: ACcGV63goaBoH9yMNm2vt5O+Wec7lNMu536nUxIAKS/CeAndAz98xdBJRIIWOA59gfmylKMb6tDHCw==
X-Received: by 2002:a17:902:286b:: with SMTP id e98-v6mr18405281plb.110.1539634611957;
        Mon, 15 Oct 2018 13:16:51 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h88-v6sm25968932pfa.184.2018.10.15.13.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:16:51 -0700 (PDT)
Subject: Re: [PATCH v3 09/18] of: overlay: validate overlay properties
 #address-cells and #size-cells
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <1539563070-12969-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <87525c4a-6c7d-5c1d-1f99-6784f315b89c@gmail.com>
Date:   Mon, 15 Oct 2018 13:16:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXQNkYDA9hRCMR_MkOJiobPjmYoJN8Gv+3YN9ReV+q5XEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 12:01, Alan Tull wrote:
> On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
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
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 272a0d1a5e18..ee66651db553 100644
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
>> +               check_for_non_overlay_node = true;
>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>                                                 new_prop);
>> -       else
>> +
>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>> +
> 
> Hi Frank,
> 
> If we get these ERROR messages, I suggest that this function should
> return an error so the overlay will be rejected.
> 
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> 
>                         *(u32 *)prop->value != *(u32 *)new_prop->value) {
> 
>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>> +                              target->np);
> 
>                        ret = -EINVAL;
>                 }
> 
> Otherwise there is an ERROR message, but it continues trying to apply
> the invalid overlay anyway and I get an oops.  By adding the ret =
> -EINVAL, the overlay gets rejected and the oops is avoided.

Yes, that sounds good.


>> +
>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>> +
>> +               if (prop->length != 4 || new_prop->length != 4 ||
>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>> +                              target->np);
> 
> Add the ret = -EINVAL here also.  This give me the following (if my
> overlay changes #address-cells):

Yes.


> [   21.167551] OF: overlay: ERROR: overlay and/or live tree
> #address-cells invalid in node /soc/base_fpga_region
> [   21.177442] OF: overlay: add_changeset_property ret=-22
> [   21.182656] create_overlay: Failed to create overlay (err=-22)
> 
> Also, I wonder if the ERROR message could be more direct.  Currently
> it says the #address-cells property is invalid but that doesn't say
> anything about why it's invalid.  How about something like:
> 
>  OF: overlay: ERROR: changing #address-cells not allowed (/soc/base_fpga_region)

That sounds like a more useful message, maybe a slight change
s/changing #address-cells/changing value of #address-cells/


> The 'OF: overlay' part still makes it clear it's overlay related.  The
> rest of it makes it clear *why* it's invalid.  This ERROR will be a
> surprise for people who have been using overlays, so that could be
> helpful to light the way a bit.
> 
> Alan
> 
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

