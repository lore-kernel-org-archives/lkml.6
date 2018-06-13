Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 845A5C07D5D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37831208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37831208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935853AbeFMO5O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:57:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935694AbeFMO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:57:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DEs3fQ113408
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:57:11 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk334yjak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:57:10 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 08:57:10 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 08:57:07 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DEv6fa6750484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 07:57:06 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD956E050;
        Wed, 13 Jun 2018 08:57:06 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C79786E04E;
        Wed, 13 Jun 2018 08:57:05 -0600 (MDT)
Received: from [9.41.102.69] (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 08:57:05 -0600 (MDT)
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        openbmc@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180612051911.20690-1-benh@kernel.crashing.org>
 <20180612051911.20690-6-benh@kernel.crashing.org>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Date:   Wed, 13 Jun 2018 09:57:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612051911.20690-6-benh@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18061314-0020-0000-0000-00000E2D056D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009183; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01046401; UDB=6.00535906; IPR=6.00825376;
 MB=3.00021625; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-13 14:57:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061314-0021-0000-0000-000061EC37E3
Message-Id: <4581896b-3e24-a5ad-b37a-a0fbf61f99c9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 12:19 AM, Benjamin Herrenschmidt wrote:
> This was too hard to split ... this adds a number of features
> to the SCOM user interface:
>
>   - Support for indirect SCOMs
>
>   - read()/write() interface now handle errors and retries
>
>   - New ioctl() "raw" interface for use by debuggers
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   drivers/fsi/fsi-scom.c   | 424 ++++++++++++++++++++++++++++++++++++---
>   include/uapi/linux/fsi.h |  56 ++++++
>   2 files changed, 450 insertions(+), 30 deletions(-)
>   create mode 100644 include/uapi/linux/fsi.h
>
> diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
> index e98573ecdae1..39c74351f1bf 100644
> --- a/drivers/fsi/fsi-scom.c
> +++ b/drivers/fsi/fsi-scom.c
> @@ -24,6 +24,8 @@
>   #include <linux/list.h>
>   #include <linux/idr.h>

> +
> +static int scom_reset(struct scom_device *scom, void __user *argp)
> +{
> +	uint32_t flags, dummy = -1;
> +	int rc = 0;
> +
> +	if (get_user(flags, (__u32 __user *)argp))
> +		return -EFAULT;
> +	if (flags & SCOM_RESET_PIB)
> +		rc = fsi_device_write(scom->fsi_dev, SCOM_PIB_RESET_REG, &dummy,
> +				      sizeof(uint32_t));

I realize this is a user requested flag but I believe the BMC is never 
supposed to issue this type of reset, due to the possibility of breaking 
stuff on the host side. Not sure if it should even be available?

Otherwise, looks good!
Thanks,
Eddie

> +	if (!rc && (flags & (SCOM_RESET_PIB | SCOM_RESET_INTF)))
> +		rc = fsi_device_write(scom->fsi_dev, SCOM_FSI2PIB_RESET_REG, &dummy,
> +				      sizeof(uint32_t));
> +	return rc;
> +}
> +
> +static int scom_check(struct scom_device *scom, void __user *argp)
> +{
> +	/* Still need to find out how to get "protected" */
> +	return put_user(SCOM_CHECK_SUPPORTED, (__u32 __user *)argp);
> +}
> +
> +static long scom_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct miscdevice *mdev = file->private_data;
> +	struct scom_device *scom = to_scom_dev(mdev);
> +	void __user *argp = (void __user *)arg;
> +	int rc = -ENOTTY;
> +
> +	mutex_lock(&scom->lock);
> +	switch(cmd) {
> +	case FSI_SCOM_CHECK:
> +		rc = scom_check(scom, argp);
> +		break;
> +	case FSI_SCOM_READ:
> +		rc = scom_raw_read(scom, argp);
> +		break;
> +	case FSI_SCOM_WRITE:
> +		rc = scom_raw_write(scom, argp);
> +		break;
> +	case FSI_SCOM_RESET:
> +		rc = scom_reset(scom, argp);
> +		break;
> +	}
> +	mutex_unlock(&scom->lock);
> +	return rc;
> +}
> +
>   static const struct file_operations scom_fops = {
> -	.owner	= THIS_MODULE,
> -	.llseek	= scom_llseek,
> -	.read	= scom_read,
> -	.write	= scom_write,
> +	.owner		= THIS_MODULE,
> +	.llseek		= scom_llseek,
> +	.read		= scom_read,
> +	.write		= scom_write,
> +	.unlocked_ioctl	= scom_ioctl,
>   };
>
>   static int scom_probe(struct device *dev)
> diff --git a/include/uapi/linux/fsi.h b/include/uapi/linux/fsi.h
> new file mode 100644
> index 000000000000..6008d93f2e48
> --- /dev/null
> +++ b/include/uapi/linux/fsi.h
> @@ -0,0 +1,56 @@
> +#ifndef _UAPI_LINUX_FSI_H
> +#define _UAPI_LINUX_FSI_H
> +
> +#include <linux/ioctl.h>
> +
> +/*
> + * /dev/scom "raw" ioctl interface
> + *
> + * The driver supports a high level "read/write" interface which
> + * handles retries and converts the status to Linux error codes,
> + * however low level tools an debugger need to access the "raw"
> + * HW status information and interpret it themselves, so this
> + * ioctl interface is also provided for their use case.
> + */
> +
> +/* Structure for SCOM read/write */
> +struct scom_access {
> +	__u64	addr;		/* SCOM address, supports indirect */
> +	__u64	data;		/* SCOM data (in for write, out for read) */
> +	__u64	mask;		/* Data mask for writes */
> +	__u32	intf_errors;	/* Interface error flags */
> +#define SCOM_INTF_ERR_PARITY		0x00000001 /* Parity error */
> +#define SCOM_INTF_ERR_PROTECTION	0x00000002 /* Blocked by secure boot */
> +#define SCOM_INTF_ERR_ABORT		0x00000004 /* PIB reset during access */
> +#define SCOM_INTF_ERR_UNKNOWN		0x80000000 /* Unknown error */
> +	/*
> +	 * Note: Any other bit set in intf_errors need to be considered as an
> +	 * error. Future implementations may define new error conditions. The
> +	 * pib_status below is only valid if intf_errors is 0.
> +	 */
> +	__u8	pib_status;	/* 3-bit PIB status */
> +#define SCOM_PIB_SUCCESS	0	/* Access successful */
> +#define SCOM_PIB_BLOCKED	1	/* PIB blocked, pls retry */
> +#define SCOM_PIB_OFFLINE	2	/* Chiplet offline */
> +#define SCOM_PIB_PARTIAL	3	/* Partial good */
> +#define SCOM_PIB_BAD_ADDR	4	/* Invalid address */
> +#define SCOM_PIB_CLK_ERR	5	/* Clock error */
> +#define SCOM_PIB_PARITY_ERR	6	/* Parity error on the PIB bus */
> +#define SCOM_PIB_TIMEOUT	7	/* Bus timeout */
> +	__u8	pad;
> +};
> +
> +/* Flags for SCOM check */
> +#define SCOM_CHECK_SUPPORTED	0x00000001	/* Interface supported */
> +#define SCOM_CHECK_PROTECTED	0x00000002	/* Interface blocked by secure boot */
> +
> +/* Flags for SCOM reset */
> +#define SCOM_RESET_INTF		0x00000001	/* Reset interface */
> +#define SCOM_RESET_PIB		0x00000002	/* Reset PIB */
> +
> +#define FSI_SCOM_CHECK	_IOR('s', 0x00, __u32)
> +#define FSI_SCOM_READ	_IOWR('s', 0x01, struct scom_access)
> +#define FSI_SCOM_WRITE	_IOWR('s', 0x02, struct scom_access)
> +#define FSI_SCOM_RESET	_IOW('s', 0x03, __u32)
> +
> +#endif /* _UAPI_LINUX_FSI_H */

