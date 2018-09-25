Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92708C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EF620877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EF620877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeIYUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:07:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35461 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727165AbeIYUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:07:54 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8PDwwqD018241;
        Tue, 25 Sep 2018 15:59:29 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncme9bbh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 15:59:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0B973A;
        Tue, 25 Sep 2018 13:59:28 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 98EC251A5;
        Tue, 25 Sep 2018 13:59:28 +0000 (GMT)
Received: from [10.48.0.167] (10.75.127.44) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 25 Sep
 2018 15:59:27 +0200
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <stefan.wahren@i2se.com>, <gohai@sukzessiv.net>,
        <hsweeten@visionengravers.com>, <gottfried.haider@gmail.com>,
        <loic.pallardy@st.com>, <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <michal.vokac@ysoft.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
Message-ID: <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com>
Date:   Tue, 25 Sep 2018 15:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 05:50 PM, Fabrice Gasnier wrote:
> On 09/24/2018 04:23 PM, Thierry Reding wrote:
>> On Mon, Sep 24, 2018 at 03:59:03PM +0200, Fabrice Gasnier wrote:
>>> On 09/24/2018 01:53 PM, Thierry Reding wrote:
>>>> On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
>>>>> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
>>>>> regression with multiple pwm chip. It creates a new entry in
>>>>> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
>>>>> - 1st time export will create an entry in /sys/class/pwm/pwmX
>>>>> - when another export happens on another pwmchip, it can't be created
>>>>> (e.g. -EEXIST)
>>>>>
>>>>> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
>>>>> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>>>>>
>>>>> Example on stm32 (stm32429i-eval) platform:
>>>>> $ ls /sys/class/pwm
>>>>> pwmchip0 pwmchip4
>>>>>
>>>>> $ cd /sys/class/pwm/pwmchip0/
>>>>> $ echo 0 > export
>>>>> $ ls /sys/class/pwm
>>>>> pwm0 pwmchip0 pwmchip4
>>>>>
>>>>> $ cd /sys/class/pwm/pwmchip4/
>>>>> $ echo 0 > export
>>>>> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>>>>> ...Exception stack follows...
>>>>>
>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>>> ---
>>>>>  drivers/pwm/sysfs.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> Can we come up with an alternative that allows us to have both? We want
>>>> uevent and proper sysfs creation, or is that not possible?
>>>
>>> Hi Thierry, all,
>>>
>>> With current approach:
>>> - "export->child.class = parent->class"
>>> - ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
>>> I think this is not possible.
>>>
>>> Trying to think of an alternative... I just did a quick test, by
>>> changing device name, to take pwmchip into account:
>>> +       export->child.class = parent->class;
>>>         export->child.release = pwm_export_release;
>>>         export->child.parent = parent;
>>>         export->child.devt = MKDEV(0, 0);
>>>         export->child.groups = pwm_groups;
>>> -       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
>>> +       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
>>> pwm->hwpwm);
>>>
>>> But this also impacts existing ABI :-(
>>> Would you have suggestions to send an uevent, without modifying ABI ?
>>
>> I don't quite understand why, in the example you show in the commit
>> message, the pwmX nodes appear in the top-level /sys/class/pwm
>> directory. According to Documentation/ABI/testing/sysfs-class-pwm they
>> should appear as /sys/class/pwm/pwmchipN/pwmX. I can only imagine that
>> setting the class may have changed that.
> 
> Yes, adding the class makes the link to be created under /sys/class/pwm:
> device_register() -> device_add() -> device_add_class_symlinks()
> In device_add_class_symlinks():
> ...
> 	if (!dev->class)
> 		return 0;
> ...
> 	/* link in the class directory pointing to the device */
> 	error = sysfs_create_link(&dev->class->p->subsys.kobj,
> 				  &dev->kobj, dev_name(dev));
> ...
> 
>> If so, perhaps we can
>> workaround that by creating a new class that is not parent->class?

Hi Thierry,

Maybe there's a way around, keeping the revert patch, without impacting
the ABI:
- pwmX cannot be added to pwm/another class without issue as discussed
(numbering isn't unique).
- pwmchipN already belongs to pwm class.

I did some testing, trying to send uevent on the pwmX directly, without
success: uevents are filtered as pwmX doesn't belong to a class.

Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
to notify of a change, e.g. pwmX channel being exported/unexported.

I run following prototype (with revert patch).

static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
+       char *pwm_prop[2];
        struct pwm_export *export;
        int ret;
 ...
                kfree(export);
                return ret;
        }
+       pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+       pwm_prop[1] = NULL;
+       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+       kfree(pwm_prop[0]);

        return 0;
 }

 static int pwm_unexport_child(struct device *parent, struct pwm_device
*pwm)
 {
        struct device *child;
+       char *pwm_prop[2];

        if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
                return -ENODEV;
...
        if (!child)
                return -ENODEV;

+       pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+       pwm_prop[1] = NULL;
+       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+       kfree(pwm_prop[0]);
+
        /* for device_find_child() */

Then, I run a quick test:

# udevadm monitor --environment &
# echo 0 > /sys/class/pwm/pwmchip0/export
KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
EXPORT=pwm0
SEQNUM=2045
SUBSYSTEM=pwm

# echo 0 > /sys/class/pwm/pwmchip4/export
KERNEL[202.089676] change   /devices/.../pwm/pwmchip4 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip4
EXPORT=pwm0
SEQNUM=2046
SUBSYSTEM=pwm


Also unexport will report change events to userland:

# echo 0 > /sys/class/pwm/pwmchip0/unexport
KERNEL[1691.112765] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
SEQNUM=2047
SUBSYSTEM=pwm
UNEXPORT=pwm0

Do you think this may be a way around?
Please let me know if this may satisfy need for uevents.

Best regards,
Fabrice
> 
> And this link is added using dev_name(). So I doubt adding a new class
> will change the current behavior.
> 
>>
>> Thierry
>>
