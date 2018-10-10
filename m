Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AE5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27F20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OksymJB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F27F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeJKE06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:26:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46426 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJKE06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:26:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id v5-v6so3083374plz.13;
        Wed, 10 Oct 2018 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMqrOoCnzZMR476FmJIyPnG+HE5csbvbrDKYDpL7dV8=;
        b=OksymJB5RAAawJYWNKfE6inzze7lWPnB8GkuLXv8NJqAcdn+omqRskvYzRvUKTlgze
         6BB8HvIpmL77UENrOc7nVuczIB36Atlk6qIK4BtEiO4M1WiWc7U49BvGDYSvYP4+fQ4W
         KziaJf0xF4XCaEUznunM0gn34uxY+23i/YZx/8yEyaSydyFByPBOSYgt5aRC+Uoc3g1+
         s3s+xbhlvZ573g8SYtrjtiVEpylD5U4JIvfK+WIoZJyP11bYQXnYt3cxocn8sGxKpQ4O
         bGMJtj5CHLGS/KN87Z4De+m0dOhnxuH2P9YCX5bOyws+rSMf4oC3CBJky9pexL+U4kIq
         Rn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMqrOoCnzZMR476FmJIyPnG+HE5csbvbrDKYDpL7dV8=;
        b=Fd4n2FnMBUj5Fx8wM92cgYM9Y9gPcLSYEwGZuZDbXogR5SugcejPkGgNMq+8UXy6E4
         5rSkZh/+lrUQD8zcYciDyYMdc5ehRts2J7sKuJ0qYlIxHrQVEqVucuZavRcdYi4OTFDM
         SbOxMhzztYi/7kq8x12P7t2za5ypRnCBdGuQ/lXsVM2QezE0CwxnUmhqbb80ak5a6bM4
         Hn99hF23VNgTNwqPRi10QUIJytoou4Mn1FwF4Y5yS29fwI19Ui29rkalPkCjpv3EmlCt
         Nsah2RItrtsOtvCpJn9IBEBiqsgLT63Sc1nJbkkSwuDfrTG4nTQ20n67GSUHHQ7QKnw5
         qqoQ==
X-Gm-Message-State: ABuFfohCxO6rpFyefB/nfpja5YIpvC6139/1Vg1fKrpGmNfNRkak7WG9
        Vr5sLTTqqCA5z+i6DI8UGxI=
X-Google-Smtp-Source: ACcGV60AHHDpZiIy9Yzt+Oqel7g+Ct6epmkStbBv7azcMLn84zIrK8TymzPaLyypSYBfk1aFluMZMQ==
X-Received: by 2002:a17:902:4225:: with SMTP id g34-v6mr34649984pld.161.1539205382190;
        Wed, 10 Oct 2018 14:03:02 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id a190-v6sm29789679pge.47.2018.10.10.14.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 14:03:01 -0700 (PDT)
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
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
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com>
Date:   Wed, 10 Oct 2018 14:03:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 13:40, Alan Tull wrote:
> On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/09/18 23:04, frowand.list@gmail.com wrote:
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>>
>>> "of: overlay: use prop add changeset entry for property in new nodes"
>>> fixed a problem where an 'update property' changeset entry was
>>> created for properties contained in nodes added by a changeset.
>>> The fix was to use an 'add property' changeset entry.
>>>
>>> This exposed more bugs in the apply overlay code.  The properties
>>> 'name', 'phandle', and 'linux,phandle' were filtered out by
>>> add_changeset_property() as special properties.  Change the filter
>>> to be only for existing nodes, not newly added nodes.
>>>
>>> The second bug is that the 'name' property does not exist in the
>>> newest FDT version, and has to be constructed from the node's
>>> full_name.  Construct an 'add property' changeset entry for
>>> newly added nodes.
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>
>>>
>>> Hi Alan,
>>>
>>> Thanks for reporting the problem with missing node names.
>>>
>>> I was able to replicate the problem, and have created this preliminary
>>> version of a patch to fix the problem.
>>>
>>> I have not extensively reviewed the patch yet, but would appreciate
>>> if you can confirm this fixes your problem.
>>>
>>> I created this patch as patch 17 of the series, but have also
>>> applied it as patch 05.1, immediately after patch 05/16, and
>>> built the kernel, booted, and verified name and phandle for
>>> one of the nodes in a unittest overlay for both cases.  So
>>> minimal testing so far on my part.
>>>
>>> I have not verified whether the series builds and boots after
>>> each of patches 06..16 if this patch is applied as patch 05.1.
>>>
>>> There is definitely more work needed for me to complete this
>>> patch because it allocates some more memory, but does not yet
>>> free it when the overlay is released.
>>>
>>> -Frank
>>>
>>>
>>>  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 67 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>> index 0b0904f44bc7..9746cea2aa91 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>       struct property *new_prop = NULL, *prop;
>>>       int ret = 0;
>>>
>>> -     if (!of_prop_cmp(overlay_prop->name, "name") ||
>>> -         !of_prop_cmp(overlay_prop->name, "phandle") ||
>>> -         !of_prop_cmp(overlay_prop->name, "linux,phandle"))
>>> -             return 0;
>>> +     if (target->in_livetree)
>>> +             if (!of_prop_cmp(overlay_prop->name, "name") ||
>>> +                 !of_prop_cmp(overlay_prop->name, "phandle") ||
>>> +                 !of_prop_cmp(overlay_prop->name, "linux,phandle"))
>>> +                     return 0;
>>
>> This is a big hammer patch.
>>
>> Nobody should waste time reviewing this patch.
> 
> I wasn't clear if you still could use the testing so I did re-run my
> test.  This patch adds back some of the missing properties, but the
> the kobject names aren't set as dev_name() returns NULL:
> 
> * without this patch some of_node properties don't show up in sysfs:
> root@arria10:~# ls
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> clocks            compatible        interrupt-parent  interrupts        reg
> 
> * with this patch, the of_node properties phandle and name are back:
> root@arria10:~#  ls
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> clocks            compatible        interrupt-parent  interrupts
>  name              phandle           reg

Thanks for the testing.  I'll keep chasing after this problem today.

This is useful data for me as I was not looking under the /sys/bus/...
tree that you reported, but was instead looking at /proc/device-tree/...
which showed the same type of problem since the overlay I was using
does not show up under /sys/bus/...

I'll have to create a useful overlay test case that will show up under
/sys/bus/...

In the meantime, can you send me the base FDT and the overlay FDT for
your test case?

Thanks,

Frank


> 
> root@arria10:~# cat
> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node/name
> freeze_controllerroot@arria10:~#  ("freeze_controller" w/o the \n so
> the name is correct)
> 
> * with or without the patch I see the behavior I reported yesterday,
> kobj names are NULL.
> root@arria10:~# ls /sys/bus/platform/drivers/altera_freeze_br/
> bind             ff200450.<NULL>  uevent           unbind
> 
> root@arria10:~# ls /sys/bus/platform/drivers/altera_gpio/
> bind             ff200010.<NULL>  ff200020.<NULL>  ff200030.<NULL>
> uevent           unbind
> 
> Alan
> 
> Alan
> 
>>
>> The following part should not be needed (though the above section might have
>> to become _slightly_ more complex).
>>
>> -Frank
>>>
>>>       if (target->in_livetree)
>>>               prop = of_find_property(target->np, overlay_prop->name, NULL);
>>> @@ -443,10 +444,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>               struct target *target, const struct device_node *overlay_node)
>>>  {
>>>       struct device_node *child;
>>> -     struct property *prop;
>>> +     struct property *prop, *name_prop;
>>> +     bool has_name = false;
>>>       int ret;
>>>
>>>       for_each_property_of_node(overlay_node, prop) {
>>> +             if (!strcmp(prop->name, "name"))
>>> +                     has_name = true;
>>>               ret = add_changeset_property(ovcs, target, prop, 0);
>>>               if (ret) {
>>>                       pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
>>> @@ -455,6 +459,57 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>               }
>>>       }
>>>
>>> +     /*
>>> +      * With FDT version 0x10 we may not have the name property,
>>> +      * recreate it here from the unit name if absent
>>> +      */
>>> +
>>> +     if (!has_name) {
>>> +             const char *p = target->np->full_name, *ps = p, *pa = NULL;
>>> +             int len;
>>> +
>>> +             /*
>>> +              * zzz
>>> +              * TODO: stash name_prop on a list in ovcs, to be freed
>>> +              * after overlay removed
>>> +              */
>>> +
>>> +             while (*p) {
>>> +                     if ((*p) == '@')
>>> +                             pa = p;
>>> +                     else if ((*p) == '/')
>>> +                             ps = p + 1;
>>> +                     p++;
>>> +             }
>>> +
>>> +             if (pa < ps)
>>> +                     pa = p;
>>> +             len = (pa - ps) + 1;
>>> +
>>> +             name_prop = kmalloc(sizeof(*name_prop), GFP_KERNEL);
>>> +             if (!name_prop)
>>> +                     return -ENOMEM;
>>> +
>>> +             name_prop->name = kstrdup("name", GFP_KERNEL);
>>> +             name_prop->value = kmalloc(len, GFP_KERNEL);
>>> +             if (!name_prop->name || !name_prop->value) {
>>> +                     ret = -ENOMEM;
>>> +                     goto err_free_name_prop;
>>> +             }
>>> +
>>> +             memcpy(name_prop->value, ps, len - 1);
>>> +             ((char *)name_prop->value)[len - 1] = 0;
>>> +
>>> +             name_prop->length = strlen(name_prop->value) + 1;
>>> +
>>> +             ret = add_changeset_property(ovcs, target, name_prop, 0);
>>> +             if (ret) {
>>> +                     pr_debug("Failed to apply name_prop @%pOF/%s, err=%d\n",
>>> +                              target->np, name_prop->name, ret);
>>> +                     goto err_free_name_prop;
>>> +             }
>>> +     }
>>> +
>>>       for_each_child_of_node(overlay_node, child) {
>>>               ret = add_changeset_node(ovcs, target, child);
>>>               if (ret) {
>>> @@ -466,6 +521,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
>>>       }
>>>
>>>       return 0;
>>> +
>>> +err_free_name_prop:
>>> +     kfree(name_prop->name);
>>> +     kfree(name_prop->value);
>>> +     kfree(name_prop);
>>> +     return ret;
>>> +
>>>  }
>>>
>>>  /*
>>>
>>
> 

