Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1679223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1679223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeKMCT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:19:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbeKMCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:19:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wACGJbcU022678
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:25:29 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqb17xscm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:25:27 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Mon, 12 Nov 2018 16:25:26 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Nov 2018 16:25:22 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wACGPLSZ23658746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 16:25:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD6E11206F;
        Mon, 12 Nov 2018 16:25:20 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90005112066;
        Mon, 12 Nov 2018 16:25:19 +0000 (GMT)
Received: from [9.41.179.222] (unknown [9.41.179.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Nov 2018 16:25:19 +0000 (GMT)
Subject: Re: [PATCH v6 00/10] hwmon and fsi: Add On-Chip Controller Driver
To:     Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rdunlap@infradead.org,
        benh@kernel.crashing.org
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
 <20181109230354.GA31326@roeck-us.net>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Mon, 12 Nov 2018 10:25:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181109230354.GA31326@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18111216-0068-0000-0000-0000035ECFFE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116425; UDB=6.00578981; IPR=6.00896533;
 MB=3.00024128; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-12 16:25:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111216-0069-0000-0000-00004666A3D9
Message-Id: <65651d7d-7c29-4cc5-7ebf-b9d33fed7500@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/2018 05:03 PM, Guenter Roeck wrote:
> On Thu, Nov 08, 2018 at 03:05:19PM -0600, Eddie James wrote:
>> From: Eddie James <eajames@linux.vnet.ibm.com>
>>
>> This series adds a hwmon driver to support the OCC on POWER8 and POWER9
>> processors. The OCC is an embedded processor that provides realtime power and
>> thermal monitoring and management.
>>
>> The series also adds a "bus" driver to handle atomic communication between the
>> service processor and the OCC on a POWER9 chip. This communication takes place
>> over FSI bus to the SBE (Self-Boot engine) FIFO, which in turn communicates
>> with the OCC. The driver for the SBEFIFO is already available as an FSI client
>> driver.
>>
>> For POWER8 OCCs, communication between the service processor and the OCC is
>> achieved over I2C bus.
>>
> I am not entirely happy with the series - there are still lots of proprietary
> attributes, and I would have preferred the use of the _info API at this point -
> but this has taken long enough. Series applied to hwmon-next. Please send any
> fixes as follow-up patches.

Thanks a lot Guenter, appreciate your help getting here.

Eddie

>
> Thanks,
> Guenter
>
>> Changes since v5:
>>   * Makefile fix when compiling both P8 and P9 versions
>>   * Spelling fix in hwmon doc
>>   * Added an additional sentence for P9 binding doc to explain that OCC isn't
>>     an FSI slave device.
>>
>> Changes since v4:
>>   * Make the hwmon attributes conform almost completely to standard names and
>>     values. The only exception is powerX_cap_user and powerX_cap_user_source.
>>   * Improve hwmon documentation.
>>   * Add ibm,p9-occ dt documentation.
>>
>> Changes since v3:
>>   * Add the FSI OCC driver.
>>   * Pull the sysfs attribute code into it's own file for cleanliness.
>>   * Various fixes for attribute creation and integer overflow.
>>
>> Changes since v2:
>>   * Add sysfs_notify for the error and throttling attributes when change is
>>     detected.
>>   * Removed occs_present counting of devices bound.
>>   * Improved remove() of P9 driver to avoid bad behavior with relation to OCC
>>     driver when unbound.
>>   * Added default cases (return EINVAL) for all sensor show functions.
>>   * Added temperature fault sensor.
>>   * Added back dt binding documentation for P9 to address checkpatch warning.
>>   * Added occs_present attribute from the poll response.
>>
>> Changes since v1:
>>   * Remove wait loop in P9 code, as that is now handled by FSI OCC driver.
>>   * Removed dt binding documentation for P9, FSI OCC driver will probe OCC hwmon
>>     driver automatically.
>>   * Moved OCC response code definitions to the OCC include file.
>>   * Fixed includes.
>>   * Changed some structure fields to __beXX as that is what they are.
>>   * Changed some errnos.
>>   * Removed some dev_err().
>>   * Refactored P8 code a bit to use #defined addresses and magic values, and
>>     changed "goto retry" to a loop.
>>   * Refactored error handling a bit.
>>
>> Eddie James (10):
>>    dt-bindings: fsi: Add P9 OCC device documentation
>>    fsi: Add On-Chip Controller (OCC) driver
>>    Documentation: hwmon: Add OCC documentation
>>    dt-bindings: i2c: Add P8 OCC hwmon device documentation
>>    hwmon: Add On-Chip Controller (OCC) hwmon driver
>>    hwmon (occ): Add command transport method for P8 and P9
>>    hwmon (occ): Parse OCC poll response
>>    hwmon (occ): Add sensor types and versions
>>    hwmon (occ): Add sensor attributes and register hwmon device
>>    hwmon (occ): Add sysfs attributes for additional OCC data
>>
>>   .../devicetree/bindings/fsi/ibm,p9-occ.txt         |   16 +
>>   .../devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt   |   25 +
>>   Documentation/hwmon/occ                            |  112 ++
>>   drivers/fsi/Kconfig                                |   10 +
>>   drivers/fsi/Makefile                               |    1 +
>>   drivers/fsi/fsi-occ.c                              |  599 +++++++++++
>>   drivers/hwmon/Kconfig                              |    2 +
>>   drivers/hwmon/Makefile                             |    1 +
>>   drivers/hwmon/occ/Kconfig                          |   31 +
>>   drivers/hwmon/occ/Makefile                         |    5 +
>>   drivers/hwmon/occ/common.c                         | 1098 ++++++++++++++++++++
>>   drivers/hwmon/occ/common.h                         |  128 +++
>>   drivers/hwmon/occ/p8_i2c.c                         |  255 +++++
>>   drivers/hwmon/occ/p9_sbe.c                         |  106 ++
>>   drivers/hwmon/occ/sysfs.c                          |  188 ++++
>>   include/linux/fsi-occ.h                            |   25 +
>>   16 files changed, 2602 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
>>   create mode 100644 Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt
>>   create mode 100644 Documentation/hwmon/occ
>>   create mode 100644 drivers/fsi/fsi-occ.c
>>   create mode 100644 drivers/hwmon/occ/Kconfig
>>   create mode 100644 drivers/hwmon/occ/Makefile
>>   create mode 100644 drivers/hwmon/occ/common.c
>>   create mode 100644 drivers/hwmon/occ/common.h
>>   create mode 100644 drivers/hwmon/occ/p8_i2c.c
>>   create mode 100644 drivers/hwmon/occ/p9_sbe.c
>>   create mode 100644 drivers/hwmon/occ/sysfs.c
>>   create mode 100644 include/linux/fsi-occ.h
>>
>> -- 
>> 1.8.3.1
>>

