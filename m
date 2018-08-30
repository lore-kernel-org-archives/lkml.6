Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B31720652
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B31720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeHaBdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:33:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbeHaBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:33:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ULTXIx052458
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:29:36 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6peqmrc2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:29:35 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 15:29:23 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 15:29:18 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ULTHk163635512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 14:29:17 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A5AC6A047;
        Thu, 30 Aug 2018 15:29:17 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F9936A058;
        Thu, 30 Aug 2018 15:29:11 -0600 (MDT)
Received: from oc6728276242.ibm.com (unknown [9.85.221.248])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 15:29:11 -0600 (MDT)
Subject: Re: [PATCH v4 2/9] Documentation: hwmon: Add OCC documentation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        mark.rutland@arm.com
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1531342898-15790-3-git-send-email-eajames@linux.vnet.ibm.com>
 <20180725163604.GA21332@roeck-us.net>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Thu, 30 Aug 2018 16:29:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725163604.GA21332@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18083021-0036-0000-0000-00000A2E10C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009640; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081200; UDB=6.00557771; IPR=6.00861185;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 21:29:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083021-0037-0000-0000-000048C5747D
Message-Id: <aa1d5818-6b64-2088-ec59-dbe09d6a3902@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/25/2018 11:36 AM, Guenter Roeck wrote:
> On Wed, Jul 11, 2018 at 04:01:31PM -0500, Eddie James wrote:
>> Document the hwmon interface for the OCC.
>>
>> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
>> ---
>>   Documentation/hwmon/occ | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/hwmon/occ
>>
>> diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
>> new file mode 100644
>> index 0000000..465fa1a
>> --- /dev/null
>> +++ b/Documentation/hwmon/occ
>> @@ -0,0 +1,73 @@
>> +Kernel driver occ-hwmon
>> +=======================
>> +
>> +Supported chips:
>> +  * POWER8
>> +  * POWER9
>> +
>> +Author: Eddie James <eajames@linux.vnet.ibm.com>
>> +
>> +Description
>> +-----------
>> +
>> +This driver supports hardware monitoring for the On-Chip Controller (OCC)
>> +embedded on POWER processors. The OCC is a device that collects and aggregates
>> +sensor data from the processor and the system. The OCC can provide the raw
>> +sensor data as well as perform thermal and power management on the system.
>> +
>> +The P8 version of this driver is a client driver of I2C. It may be probed
>> +manually if an "ibm,p8-occ-hwmon" compatible device is found under the
>> +appropriate I2C bus node in the device-tree.
>> +
>> +The P9 version of this driver is a client driver of the FSI-based OCC driver.
>> +It will be probed automatically by the FSI-based OCC driver.
>> +
>> +Sysfs entries
>> +-------------
>> +
>> +The following attributes are supported. All attributes are read-only unless
>> +specified.
>> +
>> +temp[1-n]_label		OCC sensor id.
>> +temp[1-n]_input		Measured temperature in millidegrees C.
>> +[with temperature sensor version 2+]
>> +    temp[1-n]_fru_type		Given FRU (Field Replaceable Unit) type.
> What is this ? An integer ? A string ?
>
>> +    temp[1-n]_fault		Temperature sensor fault.
>> +
>> +freq[1-n]_label		OCC sensor id.
>> +freq[1-n]_input		Measured frequency.
> What does that have to do with hardware monitoring, and what exactly does it
> measure ? AC voltage frequency ? Frequency of rainstorms in the surrounding
> area ?
>
>> +
>> +power[1-n]_label	OCC sensor id.
>> +power[1-n]_input	Measured power in microwatts.
>> +power[1-n]_update_tag	Number of 250us samples represented in accumulator.
> update_tag to represent number of samples ? Odd choice for
> an attribute name. Why not "_samples" ? Also, if each sample
> represents a specific amount of time, why not report a time ?
>
>> +power[1-n]_accumulator	Accumulation of 250us power readings.
> There is no explanation of "accumulation". Is this the energy ?
> If so, why not use energy attributes ? And what is the unit of
> this measurement ?
>
>> +[with power sensor version 2+]
>> +    power[1-n]_function_id	Identifies what the power reading is for.
> String ? Number ? Slot index ?  Bitmap ? And why isn't that reported
> in the label ? After all, that is what the label is supposed to be
> used for.
>
>> +    power[1-n]_apss_channel	Indicates APSS channel.
>> +
> Does that provide any value to the user ?
>
>> +[power version 0xa0 only]
>> +power1_id			OCC sensor id.
> This is inconsistent with the other attributes and even with itself.
>
>> +power[1-n]_label		Sensor type, "system", "proc", "vdd", or "vdn".
>> +power[1-n]_input		Most recent power reading in microwatts.
> Overall I am left with no idea what
> 	_id
> 	_label
> 	_function_id
> 	_apps_channel
> are and how they relate to each other, except that it all looks quite
> inconsistent. You might want to consider merging all those attributes into
> the label in some consistent way.
>
>> +power[1-n]_update_tag		Number of samples in the accumulator.
>> +power[1-n]_accumulator		Accumulation of power readings.
> Same as above.
>
>> +[with sensor type "system" and "proc" only]
>> +    power[1-n]_update_time	Time in us that the power value is read.
>> +
>> +caps1_current		Current OCC power cap in watts.
>> +caps1_reading		Current system output power in watts.
>> +caps1_norm		Power cap without redundant power.
>> +caps1_max		Maximum power cap.
> Why do those have to be non-standard attributes ? Please explain why you can not
> use power[1-n]_cap attributes.
>
>> +[caps version 1 and 2 only]
>> +    caps1_min		Minimum power cap.
>> +[caps version 3+]
>> +    caps1_min_hard		Hard minimum cap that can be set and held.
>> +    caps1_min_soft		Soft minimum cap below hard, not guaranteed.
>> +caps1_user		The powercap specified by the user. Will be 0 if no
>> +			user powercap exists. This attribute is read-write.
>> +[caps version 1+]
>> +    caps1_user_source	Indicates how the user power limit was set.
>> +
>> +extn[1-n]_label		ASCII id or sensor id.
>> +extn[1-n]_flags		Indicates type of label attribute.
>> +extn[1-n]_input		Data.
> Great non-explanation.
>
> Not reviewing the series further. I am sure I asked that each non-standard
> attribute is explained. There is neither an explanation why the attributes
> are needed nor, in many cases, why non-standard attributes were chosen
> instead of standard ones. On top of that, the non-standard attributes are
> not even documented properly, leaving the reader wondering not only why
> they are needed, but what they are used for in the first place.

Hi,

Thanks for the feedback Guenter. I am about to put up a new patch set 
with fixes for many of the issues you indicated and better descriptions. 
Now all the attributes except two should conform to standard hwmon 
attributes. The exceptions are for the user power cap and user power cap 
source. These are needed in order to make decisions about power 
management while controlling the system. Please look at their 
documentation to see if they're acceptable.

Let me know what you think!
Thanks,
Eddie

>
> Guenter
>

