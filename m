Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B611C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D02098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlJ5AyoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54D02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJQFA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:00:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37279 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:00:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so11433326pgq.4;
        Tue, 16 Oct 2018 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cHyXqg8q4dn2LL/7wllRPQAouFlA/zEhsYIcn80Rfk4=;
        b=NlJ5AyoYDoZVLoMyHa2tGTbP4EIqWoGraeMHi0DgB0SU28y29/wNgwLWyWIvlsvX81
         MtGxitxIJDtMDkqooo0I/RF3cvrnVSaizqFbS3FCtEUIursPkPhSfm+gkJlltP+5+B8a
         nCvMaXM+fVpunbgwF2jzdj/QeRukztlyg60D50W3Zhab+J+IR+/8AzzLgSGJpVPRvfRi
         tZVLdey1x0qpUY7W92rsrPhsEgJXd1T713w6+h/610WWRyUmwCsmeZoBYv0SkhOeJHGc
         csWXQsOPxQOxGzJZ8JbYwrutEXGzkQELWhtlWmoWUz2gxVWg0V0sCi9QbrQJik7XvbyZ
         CZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHyXqg8q4dn2LL/7wllRPQAouFlA/zEhsYIcn80Rfk4=;
        b=O+pUcPbVd6xXwSuLxa33jJs1fvwfVpHFaQU0zPdDTq8NhSWQe6tsJEjscz7o6NtsrP
         mPZrlKC8qIP1FRULhgU6ibqCL4QlyzK+nORLSc931cMpbYRar63AiYBd/gSQshmJO3ay
         b4QuvvST3ShUiJh4qxGpq/btcAzZntKO9P7DCSvH2q/XkrwkwfkrQdf88N8ZOz3MWinX
         R4bABz8ERC7YKQTEtavc3QRy+NtwmqHpx9SsFx9pu0CKLBykumTseFiINZCHocav64kj
         3+pLjW9jtEf5wjV8fBEvC2YeMRB4rlf8gIcJzznQR9j7+ffJPD22M0zMw9NzRtuV+yyw
         x/CQ==
X-Gm-Message-State: ABuFfohUgCF8bWuBvFk+HUEACZVlTPewY446+9pHQtXaLWjamFDrg7WK
        IabOy82233HidTKbgkaOO3A=
X-Google-Smtp-Source: ACcGV63t89fmu7SQYVaNbNRCBfhzz3sDb8yItxZQ0RvGxP0NQLV0h1oHFc+76EDQ25WQLjQWyWFTkA==
X-Received: by 2002:a62:4803:: with SMTP id v3-v6mr24444472pfa.89.1539724121869;
        Tue, 16 Oct 2018 14:08:41 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u190-v6sm19377736pgu.3.2018.10.16.14.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:08:41 -0700 (PDT)
Subject: Re: [PATCH v2] of: overlay: user space synchronization
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <1539649621-5518-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXR1CRtons4RYtN3y=8EY0+31vUufei4O_EAr2mNaunLJA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <85f1be04-03f1-135a-2e0d-c83980fbba9b@gmail.com>
Date:   Tue, 16 Oct 2018 14:08:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXR1CRtons4RYtN3y=8EY0+31vUufei4O_EAr2mNaunLJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Thanks for all the suggestions!


On 10/16/18 13:04, Alan Tull wrote:
> On Mon, Oct 15, 2018 at 7:28 PM <frowand.list@gmail.com> wrote:
> 
> Hi Frank,
> 
> Thanks for all your work on this!
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> When an overlay is applied or removed, the live devicetree visible in
>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>> changes.  There is no method for user space to determine whether the
>> live devicetree was modified by overlay actions.
>>
>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>> user space to determine if the live devicetree has remained unchanged
>> while a series of one or more accesses of /proc/device-tree/ occur.
>>
>> The use of both dynamic devicetree modifications and overlay apply and
>> removal are not supported during the same boot cycle.  Thus non-overlay
>> dynamic modifications are not reflected in the value of tree_version.
>>
>> Example shell use:
>>

I'll add:
           # not done

>>         done=1
>>
> 
> Suggest a few comments, such as:

Yes to adding all of the suggested comments below.  They should make
the shell code more readable.


> + # Keep trying until we can make it through the loop without live
> tree being changed
> + # by an overlay during the 'critical region'
> 
>>         while [ $done = 1 ] ; do
> 
> Nit: doesn't $done mean 'not done' in this script (assuming True is 1)?

Maybe a bad habit on my part, but since a program return value of 0 is
true and non-zero if false, I use 0 for true and 1 for false in shell
scripts.  It confuses my C-based brain, but is consistent within the
script.


>>
>>                 pre_version=$(cat /sys/firmware/devicetree/tree_version)
> 
> Suggest:
> + # loop while live tree is locked for overlay changes
> 
>>                 while [ $(( ${pre_version} & 1 )) != 0 ] ; do
>>                         # echo is optional, sleep value can be tuned
>>                         echo "${pre_version}  locked, sleeping 2 seconds"
>>                         sleep 2;
>>                         pre_version=$(cat /sys/firmware/devicetree/tree_version)
>>                         version=${pre_version}
> 
> Unused 'version' variable

Thanks, I missed removing that in the comment.


>>                 done
>>
>>                 # 'critical region'
>>                 # access /proc/device-tree/ one or more times
>>
>>                 post_version=$(cat /sys/firmware/devicetree/tree_version)
>>
> 
> + # Final check that DT wasn't possibly overlaid during the critical region
> 
>>                 if [ ${post_version} = ${pre_version} ] ; then

I'll add (a little verbose, but clarity is key here):
                           # set done true

>>                         done=0
> 
> This threw me off for a moment as I was figuring at first that setting
> done = 0 meant that we weren't done, so keep looping.
> 
>>                 fi
>>
>>         done
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> updates since v1:
>>   - removed unneeded variable "version" from shell script
>>   - explicitly state that an odd value of tree_version means the
>>     devicetree is locked for an overlay update not just in the
>>     source, but also in Documentation/ABI/testing/sysfs-firmware-ofw
>>   - document that tree_version is reported as an ascii number, the
>>     internal representation, and the resultant wrap around behavior
>>
>>  Documentation/ABI/testing/sysfs-firmware-ofw | 67 +++++++++++++++++++++++++---
>>  drivers/of/base.c                            | 66 +++++++++++++++++++++++++++
>>  drivers/of/of_private.h                      |  2 +
>>  drivers/of/overlay.c                         | 12 +++++
>>  4 files changed, 140 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-firmware-ofw b/Documentation/ABI/testing/sysfs-firmware-ofw
>> index edcab3ccfcc0..d2346eb61924 100644
>> --- a/Documentation/ABI/testing/sysfs-firmware-ofw
>> +++ b/Documentation/ABI/testing/sysfs-firmware-ofw
>> @@ -1,4 +1,10 @@
>> -What:          /sys/firmware/devicetree/*
>> +What:          /sys/firmware/devicetree/
>> +Date:          November 2013
>> +Contact:       Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
>> +Description:
>> +               Top level Open Firmware, aka devicetree, sysfs directory.
>> +
>> +What:          /sys/firmware/devicetree/base
>>  Date:          November 2013
>>  Contact:       Grant Likely <grant.likely@arm.com>, devicetree@vger.kernel.org
>>  Description:
>> @@ -6,11 +12,6 @@ Description:
>>                 hardware, the device tree structure will be exposed in this
>>                 directory.
>>
>> -               It is possible for multiple device-tree directories to exist.
>> -               Some device drivers use a separate detached device tree which
>> -               have no attachment to the system tree and will appear in a
>> -               different subdirectory under /sys/firmware/devicetree.
>> -
>>                 Userspace must not use the /sys/firmware/devicetree/base
>>                 path directly, but instead should follow /proc/device-tree
>>                 symlink. It is possible that the absolute path will change
>> @@ -20,13 +21,65 @@ Description:
>>                 filesystem support, and has largely the same semantics and
>>                 should be compatible with existing userspace.
>>
>> -               The contents of /sys/firmware/devicetree/ is a
>> +               The /sys/firmware/devicetree/base directory is the root
>> +               node of the devicetree.
>> +
>> +               The contents of /sys/firmware/devicetree/base is a
>>                 hierarchy of directories, one per device tree node. The
>>                 directory name is the resolved path component name (node
>>                 name plus address). Properties are represented as files
>>                 in the directory. The contents of each file is the exact
>>                 binary data from the device tree.
>>
>> +What:          /sys/firmware/devicetree/tree_version
>> +Date:          October 2018
>> +KernelVersion: 4.20
>> +Contact:       Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
>> +Description:
>> +               When an overlay is applied or removed, the live devicetree
>> +               visible in /proc/device-tree/, aka
>> +               /sys/firmware/devicetree/base/, reflects the changes.
>> +
>> +               tree_version provides a way for user space to determine if the
>> +               live devicetree has remained unchanged while a series of one
>> +               or more accesses of /proc/device-tree/ occur.  If tree_version
>> +               is odd then the devicetree is locked for an overlay update.
> 
> This explains the intention very clearly and directly.
> 
> I think it would help to give more of an idea of its behavior.  I
> initially had to look at the code to understand what kind of values to
> expect and whether the tree_version somehow actually reflected some
> version # that I hadn't known about, hidden in DT somewhere.  It would
> be helpful to have it spelled out what granularity this counter has
> and some other things about its behavior, somehow explaining that
> * tree_version is a counter that is incremented and never decremented
> * tree_version is incremented twice per change
> * that the granularity is an overlay, tree_version is not counting
> changeset changes or something else
> * tree_version is updated (incremented) for both applied and for
> removed overlays
> 
> Such as:
> 
> tree_version is incremented twice for each overlay that is applied or
> removed (and never decremented).  When the tree is locked for
> processing an overlay, tree_version is incremented once and its value
> becomes odd.  Then when the overlay is done being applied or removed,
> the tree is unlocked and tree_version is incremented again, becoming
> an even value.

I'll add this.


>> +
>> +               The contents of tree_version is the ascii representation of
>> +               a kernel unsigned 32 bit int variable, thus when incremented
>> +               from 4294967295 it will wrap around to 0.
>> +
>> +               The use of both dynamic devicetree modifications and overlay
>> +               apply and removal are not supported during the same boot
>> +               cycle.  Thus non-overlay dynamic modifications are not
>> +               reflected in the value of tree_version.
>> +
>> +               Example shell use of tree_version:
>> +
> 
> Same comments as in the header about adding some comments and possibly
> reconsidering the 'done' variable.

I'll make the same changes here.

-Frank


>> +               done=1
>> +
>> +               while [ $done = 1 ] ; do
>> +
>> +                  pre_version=$(cat /sys/firmware/devicetree/tree_version)
>> +                  while [ $(( ${pre_version} & 1 )) != 0 ] ; do
>> +                     # echo is optional, sleep value can be tuned
>> +                     echo "${pre_version}  tree locked, sleeping 2 seconds"
>> +                     sleep 2;
>> +                     pre_version=$(cat /sys/firmware/devicetree/tree_version)
>> +                  done
>> +
>> +                  # 'critical region'
>> +                  # access /proc/device-tree/ one or more times
>> +
>> +                  post_version=$(cat /sys/firmware/devicetree/tree_version)
>> +
>> +                  if [ ${post_version} = ${pre_version} ] ; then
>> +                     done=0
>> +                  fi
>> +
>> +               done
>> +
>> +
>>  What:          /sys/firmware/fdt
>>  Date:          February 2015
>>  KernelVersion: 3.19
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 466e3c8582f0..ec0428e47577 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -151,9 +151,71 @@ int of_free_phandle_cache(void)
>>  late_initcall_sync(of_free_phandle_cache);
>>  #endif
>>
>> +#define show_one(object)                                               \
>> +       static ssize_t show_##object                                    \
>> +       (struct kobject *kobj, struct attribute *attr, char *buf)       \
>> +       {                                                               \
>> +               return sprintf(buf, "%u\n", object);                    \
>> +       }
>> +
>> +struct global_attr {
>> +       struct attribute attr;
>> +       ssize_t (*show)(struct kobject *kobj,
>> +                       struct attribute *attr, char *buf);
>> +       ssize_t (*store)(struct kobject *a, struct attribute *b,
>> +                        const char *c, size_t count);
>> +};
>> +
>> +#define define_one_global_ro(_name)            \
>> +static struct global_attr attr_##_name =       \
>> +__ATTR(_name, 0444, show_##_name, NULL)
>> +
>> +/*
>> + * tree_version must be unsigned so that at maximum value it wraps
>> + * from an odd value (4294967295) to an even value (0).
>> + */
>> +static u32 tree_version;
>> +
>> +show_one(tree_version);
>> +
>> +define_one_global_ro(tree_version);
>> +
>> +static struct attribute *of_attributes[] = {
>> +       &attr_tree_version.attr,
>> +       NULL
>> +};
>> +
>> +static const struct attribute_group of_attr_group = {
>> +       .attrs = of_attributes,
>> +};
>> +
>> +/*
>> + * internal documentation
>> + * tree_version_increment() - increment base version
>> + *
>> + * Before starting overlay apply or overlay remove, call this function.
>> + * After completing overlay apply or overlay remove, call this function.
>> + *
>> + * caller must hold of_mutex
>> + *
>> + * Userspace can use the value of this variable to determine whether the
>> + * devicetree has changed while accessing the devicetree.  An odd value
>> + * means a modification is underway.  An even value means no modification
>> + * is underway.
>> + *
>> + * The use of both (1) dynamic devicetree modifications and (2) overlay apply
>> + * and removal are not supported during the same boot cycle.  Thus non-overlay
>> + * dynamic modifications are not reflected in the value of tree_version.
>> + */
>> +void tree_version_increment(void)
>> +{
>> +       tree_version++;
>> +}
>> +
>>  void __init of_core_init(void)
>>  {
>>         struct device_node *np;
>> +       int ret;
>>
>>         of_populate_phandle_cache();
>>
>> @@ -172,6 +234,10 @@ void __init of_core_init(void)
>>         /* Symlink in /proc as required by userspace ABI */
>>         if (of_root)
>>                 proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>> +
>> +       ret = sysfs_create_group(&of_kset->kobj, &of_attr_group);
>> +       if (ret)
>> +               pr_err("sysfs_create_group of_attr_group failed: %d\n", ret);
>>  }
>>
>>  static struct property *__of_find_property(const struct device_node *np,
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 216175d11d3d..adf89f6bad81 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -31,6 +31,8 @@ struct alias_prop {
>>  extern struct list_head aliases_lookup;
>>  extern struct kset *of_kset;
>>
>> +void tree_version_increment(void);
>> +
>>  #if defined(CONFIG_OF_DYNAMIC)
>>  extern int of_property_notify(int action, struct device_node *np,
>>                               struct property *prop, struct property *old_prop);
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index eda57ef12fd0..53b1810b1e03 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -770,6 +770,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>         of_overlay_mutex_lock();
>>         mutex_lock(&of_mutex);
>>
>> +       /* live tree may change after this point, user space synchronization */
>> +       tree_version_increment();
>> +
>>         ret = of_resolve_phandles(tree);
>>         if (ret)
>>                 goto err_free_tree;
>> @@ -832,6 +835,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>         free_overlay_changeset(ovcs);
>>
>>  out_unlock:
>> +       /* live tree change complete, user space synchronization */
>> +       tree_version_increment();
>> +
>>         mutex_unlock(&of_mutex);
>>         of_overlay_mutex_unlock();
>>
>> @@ -1028,6 +1034,9 @@ int of_overlay_remove(int *ovcs_id)
>>
>>         mutex_lock(&of_mutex);
>>
>> +       /* live tree may change after this point, user space synchronization */
>> +       tree_version_increment();
>> +
>>         ovcs = idr_find(&ovcs_idr, *ovcs_id);
>>         if (!ovcs) {
>>                 ret = -ENODEV;
>> @@ -1083,6 +1092,9 @@ int of_overlay_remove(int *ovcs_id)
>>         free_overlay_changeset(ovcs);
>>
>>  out_unlock:
>> +       /* live tree change complete, user space synchronization */
>> +       tree_version_increment();
>> +
>>         mutex_unlock(&of_mutex);
>>
>>  out:
>> --
> 
> Thanks!
> Alan
> 
>> Frank Rowand <frank.rowand@sony.com>
>>
> 

