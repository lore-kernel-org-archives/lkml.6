Return-Path: <prvs=574ef6db7=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x225dvSLkWQTCd/YgZXfXOtCCBlJ1KXiwaAETEpC+irUassY9tHd026uJRf6Kz1rMPDljRaqK
ARC-Seal: i=1; a=rsa-sha256; t=1518433588; cv=none;
        d=google.com; s=arc-20160816;
        b=c8gSsM9jgIKbK5nyUaRrRPTvLmy21jy9lILUiCLMKZWF0LLDdfkLyBHGu5iDfh01kF
         ijeTsN+NOEy0gDZsoAKcYkWwzeBFUhu3TfwGTbeWmPcQmj2Eo1rCewAme615fc8GLm5T
         PeBCXp9x2klIvRGnUxezSvCHqPjUKSefVOIkdVvzt4uP6zlUbSyDKWTcoVW8dHdzUEMS
         ohXJb0ZUpJAFIwD4HVCY5JQ9vXfkwZG2uj/f7ab4PcQ0sDc4eUM7aEk5NLr427+FjhAC
         zBUrvYYyxCxCS5PTTNiWhL0J05goHeepR73xA1AG/zEKcwrzz7lG1Ej1XKmdFJol2jxO
         fvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ZbBTQ0L5Ha7gEBP/c3JiRQaH0CmD9Yd0nDtorlHVm5w=;
        b=yKBTB4GR6Vw/75dLRNGxa6Whx/65WN0OXRiF58Z2/SK50qXc7e7TwwEnOw+n0vMuyQ
         FMBVDhfJ3VbTfS3iwzfRD3XQkXjVkW9Mw7UPJdpAOyKJ5CEHxA4zgmvaiFBinzSB6LsT
         Cv9UqbHOM4H6znpiDNenaDRQ8BqJAoFQeyLGD44duv1Y93LrYiBPlUv6JSLqncRFRUfF
         owCwXrPMpC0iJMx3aRGxrRdnOHgBoqhH9zxA0Bf73W3ZQNouuqalzGoYCOlZjPYQISBQ
         maMLdG73WvLt/Oc0oGN/jPvQA9qsO5LZSzIufPbu5VgoRO+eaX8Vz7M7pMi82xtjO08p
         m/SA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Y9gDYZhI;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=EVqRMRhG;
       spf=pass (google.com: domain of prvs=574ef6db7=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=574ef6db7=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Y9gDYZhI;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=EVqRMRhG;
       spf=pass (google.com: domain of prvs=574ef6db7=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=574ef6db7=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,501,1511798400";
   d="scan'208";a="167589815"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: RE: [PATCH v5 01/11] scsi: ufs: sysfs: attribute group for existing
 sysfs entries.
Thread-Topic: [PATCH v5 01/11] scsi: ufs: sysfs: attribute group for existing
 sysfs entries.
Thread-Index: AQHTn2R5fy50aEgK9EOse6/Z8f9mVKOf/IMAgAClzAA=
Date: Mon, 12 Feb 2018 11:06:23 +0000
Message-ID: <CY1PR0401MB09696392A231353F0ED0DD359AF70@CY1PR0401MB0969.namprd04.prod.outlook.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517933183-30892-2-git-send-email-stanislav.nijnikov@wdc.com>
 <20180212010602.GC44666@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20180212010602.GC44666@jaegeuk-macbookpro.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1049;7:ypJmjxzEBVCv6hHVX62AnYrNK7GsrfcjV5/ofm21PrD4cOE07kg2gLe3ISmNjMBzVxO3LqZut6GuZqEMQWZIjJ4LrXZImSn50r/ewDdnqV7Y+Z+JQQjn2fHpMMqjjJitzEHG4gAwPXmjYdxYkFUiwiILvKKFgHqA3P+rbqoPtnXUQ5IkuVE2JG9W3YW4XlQv6E8jv+xrI4hrBUfVtT8SaoMhM4kc5IXb19qa25dHI9zizJjHVLKpzjFWfU3Ly0Lz;20:9hqHA5mYM9tI3gXMJBWnVTyndhbzHk7CJSZCZMSDP7Nhbp+Z3Dtwlq1BEAbW1F86jIudpQVMDbCVybMKWoFmwIroLXfe5kJNm9nKAE/ZAgGzKvovDuw4i/TCtq79FlPCDeFTIlOP7gmrkkcJgZOdw8EULcLwXpDJqS4zoOoFDQs=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f4540c2-9e23-4456-27f8-08d57208a756
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1049;
x-ms-traffictypediagnostic: CY1PR0401MB1049:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1049C84EDE2E946BCF61D9B69AF70@CY1PR0401MB1049.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0401MB1049;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1049;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(13464003)(189003)(199004)(99286004)(26005)(33656002)(5660300001)(186003)(59450400001)(3846002)(74316002)(8936002)(6116002)(81156014)(316002)(478600001)(53546011)(6506007)(2900100001)(14454004)(81166006)(72206003)(102836004)(305945005)(6916009)(2906002)(3280700002)(2950100002)(97736004)(105586002)(106356001)(3660700001)(7736002)(7696005)(68736007)(77096007)(6436002)(54906003)(66066001)(86362001)(575784001)(229853002)(55016002)(53936002)(9686003)(25786009)(8676002)(53946003)(4326008)(6246003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1049;H:CY1PR0401MB0969.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 8YyGhjRy+xAm6ZQkm2kh9BqblCGxD9848CAF5XOIBByzcwiCW+IgL3/5PZMYz7gTlWq5B1wBpcPSi8p/qMoNng==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4540c2-9e23-4456-27f8-08d57208a756
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 11:06:23.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1049
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668315913733623?=
X-GMAIL-MSGID: =?utf-8?q?1592193018677982466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Monday, February 12, 2018 3:06 AM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> gregkh@linuxfoundation.org; Alex Lemberg <Alex.Lemberg@wdc.com>
> Subject: Re: [PATCH v5 01/11] scsi: ufs: sysfs: attribute group for exist=
ing
> sysfs entries.
>=20
> On 02/06, Stanislav Nijnikov wrote:
> > This patch introduces attribute group to show existing sysfs entries.
> >
> > Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > ---
> >  drivers/scsi/ufs/Makefile    |   3 +-
> >  drivers/scsi/ufs/ufs-sysfs.c | 156
> > +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/scsi/ufs/ufs-sysfs.h |  14 ++++
> >  drivers/scsi/ufs/ufshcd.c    | 156 ++---------------------------------=
--------
> >  drivers/scsi/ufs/ufshcd.h    |   2 +
> >  5 files changed, 178 insertions(+), 153 deletions(-)  create mode
> > 100644 drivers/scsi/ufs/ufs-sysfs.c  create mode 100644
> > drivers/scsi/ufs/ufs-sysfs.h
> >
> > diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> > index 9310c6c..918f579 100644
> > --- a/drivers/scsi/ufs/Makefile
> > +++ b/drivers/scsi/ufs/Makefile
> > @@ -3,6 +3,7 @@
> >  obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-
> dwc.o
> > tc-dwc-g210.o
> >  obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o
> > ufshcd-dwc.o tc-dwc-g210.o
> >  obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
> > -obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd.o
> > +obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o ufshcd-core-objs :=3D
> > +ufshcd.o ufs-sysfs.o
> >  obj-$(CONFIG_SCSI_UFSHCD_PCI) +=3D ufshcd-pci.o
> >  obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) +=3D ufshcd-pltfrm.o diff --git
> > a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c new file
> > mode 100644 index 0000000..ce8dcb6
> > --- /dev/null
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -0,0 +1,156 @@
> > +// SPDX-License-Identifier: GPL-2.0-only // Copyright (C) 2018
> > +Western Digital Corporation
> > +
> > +#include <linux/err.h>
> > +#include <linux/string.h>
> > +
> > +#include "ufs-sysfs.h"
> > +
> > +static const char *ufschd_uic_link_state_to_string(
> > +			enum uic_link_state state)
> > +{
> > +	switch (state) {
> > +	case UIC_LINK_OFF_STATE:	return "OFF";
> > +	case UIC_LINK_ACTIVE_STATE:	return "ACTIVE";
> > +	case UIC_LINK_HIBERN8_STATE:	return "HIBERN8";
> > +	default:			return "UNKNOWN";
> > +	}
> > +}
> > +
> > +static const char *ufschd_ufs_dev_pwr_mode_to_string(
> > +			enum ufs_dev_pwr_mode state)
> > +{
> > +	switch (state) {
> > +	case UFS_ACTIVE_PWR_MODE:	return "ACTIVE";
> > +	case UFS_SLEEP_PWR_MODE:	return "SLEEP";
> > +	case UFS_POWERDOWN_PWR_MODE:	return "POWERDOWN";
> > +	default:			return "UNKNOWN";
> > +	}
> > +}
> > +
> > +static inline ssize_t ufs_sysfs_pm_lvl_store(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     const char *buf, size_t count,
> > +					     bool rpm)
> > +{
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	unsigned long flags, value;
> > +
> > +	if (kstrtoul(buf, 0, &value))
> > +		return -EINVAL;
> > +
> > +	if (value >=3D UFS_PM_LVL_MAX)
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(hba->host->host_lock, flags);
> > +	if (rpm)
> > +		hba->rpm_lvl =3D value;
> > +	else
> > +		hba->spm_lvl =3D value;
> > +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> > +	return count;
> > +}
> > +
> > +static ssize_t rpm_lvl_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf) {
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	int curr_len;
> > +	u8 lvl;
> > +
> > +	curr_len =3D snprintf(buf, PAGE_SIZE,
> > +			    "\nCurrent Runtime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +			    hba->rpm_lvl,
> > +			    ufschd_ufs_dev_pwr_mode_to_string(
> > +				ufs_pm_lvl_states[hba-
> >rpm_lvl].dev_state),
> > +			    ufschd_uic_link_state_to_string(
> > +				ufs_pm_lvl_states[hba-
> >rpm_lvl].link_state));
>=20
> If there is no objection regarding to backward compatibility, can we also=
 clean
> this up by adding multiple entries having single string each, as Greg
> recommended?
>=20
> For example,
>=20
> /rpm_level
> 1
>=20
> /rpm_dev_state
> ACTIVE
>=20
> /rpm_link_state
> HIBERN8
>=20
> /spm_level
> 2
>=20
> /spm_dev_state
> SLEEP
>=20
> /spm_link_state
> ACTIVE
>=20
> /avail_dev_states
> 0:ACTIVE 1:ACTIVE 2:SLEEP 3:SLEEP 4:POWERDOWN 5:POWERDOWN
>=20
> /avail_link_states
> 0:ACTIVE 1:HIBERN8 2:ACTIVE 3:HIBERN8 4:HIBERN8 5:OFF
>=20
> Thanks,
>=20
Hi,
We are planning to fix this in a separate patch.

Regards

> > +
> > +	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +			     "\nAll available Runtime PM levels info:\n");
> > +	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > +		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +				     "\tRuntime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +				    lvl,
> > +				    ufschd_ufs_dev_pwr_mode_to_string(
> > +					ufs_pm_lvl_states[lvl].dev_state),
> > +				    ufschd_uic_link_state_to_string(
> > +					ufs_pm_lvl_states[lvl].link_state));
> > +
> > +	return curr_len;
> > +}
> > +
> > +static ssize_t rpm_lvl_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count) {
> > +	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, true); }
> > +
> > +static ssize_t spm_lvl_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf) {
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	int curr_len;
> > +	u8 lvl;
> > +
> > +	curr_len =3D snprintf(buf, PAGE_SIZE,
> > +			    "\nCurrent System PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +			    hba->spm_lvl,
> > +			    ufschd_ufs_dev_pwr_mode_to_string(
> > +				ufs_pm_lvl_states[hba-
> >spm_lvl].dev_state),
> > +			    ufschd_uic_link_state_to_string(
> > +				ufs_pm_lvl_states[hba-
> >spm_lvl].link_state));
> > +
> > +	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +			     "\nAll available System PM levels info:\n");
> > +	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > +		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +				     "\tSystem PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +				    lvl,
> > +				    ufschd_ufs_dev_pwr_mode_to_string(
> > +					ufs_pm_lvl_states[lvl].dev_state),
> > +				    ufschd_uic_link_state_to_string(
> > +					ufs_pm_lvl_states[lvl].link_state));
> > +
> > +	return curr_len;
> > +}
> > +
> > +static ssize_t spm_lvl_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count) {
> > +	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, false); }
> > +
> > +static DEVICE_ATTR_RW(rpm_lvl);
> > +static DEVICE_ATTR_RW(spm_lvl);
> > +
> > +static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D {
> > +	&dev_attr_rpm_lvl.attr,
> > +	&dev_attr_spm_lvl.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group ufs_sysfs_default_group =3D {
> > +	.attrs =3D ufs_sysfs_ufshcd_attrs,
> > +};
> > +
> > +static const struct attribute_group *ufs_sysfs_groups[] =3D {
> > +	&ufs_sysfs_default_group,
> > +	NULL,
> > +};
> > +
> > +void ufs_sysfs_add_nodes(struct device *dev) {
> > +	int ret;
> > +
> > +	ret =3D sysfs_create_groups(&dev->kobj, ufs_sysfs_groups);
> > +	if (ret)
> > +		dev_err(dev,
> > +			"%s: sysfs groups creation failed (err =3D %d)\n",
> > +			__func__, ret);
> > +}
> > +
> > +void ufs_sysfs_remove_nodes(struct device *dev) {
> > +	sysfs_remove_groups(&dev->kobj, ufs_sysfs_groups); }
> > diff --git a/drivers/scsi/ufs/ufs-sysfs.h
> > b/drivers/scsi/ufs/ufs-sysfs.h new file mode 100644 index
> > 0000000..4a984ca
> > --- /dev/null
> > +++ b/drivers/scsi/ufs/ufs-sysfs.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only
> > + * Copyright (C) 2018 Western Digital Corporation  */
> > +
> > +#ifndef __UFS_SYSFS_H__
> > +#define __UFS_SYSFS_H__
> > +
> > +#include <linux/sysfs.h>
> > +
> > +#include "ufshcd.h"
> > +
> > +void ufs_sysfs_add_nodes(struct device *dev); void
> > +ufs_sysfs_remove_nodes(struct device *dev); #endif
> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > index a355d98..e7621a0a 100644
> > --- a/drivers/scsi/ufs/ufshcd.c
> > +++ b/drivers/scsi/ufs/ufshcd.c
> > @@ -44,6 +44,7 @@
> >  #include "ufshcd.h"
> >  #include "ufs_quirks.h"
> >  #include "unipro.h"
> > +#include "ufs-sysfs.h"
> >
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/ufs.h>
> > @@ -150,7 +151,7 @@ enum {
> >  #define ufshcd_is_ufs_dev_poweroff(h) \
> >  	((h)->curr_dev_pwr_mode =3D=3D UFS_POWERDOWN_PWR_MODE)
> >
> > -static struct ufs_pm_lvl_states ufs_pm_lvl_states[] =3D {
> > +struct ufs_pm_lvl_states ufs_pm_lvl_states[] =3D {
> >  	{UFS_ACTIVE_PWR_MODE, UIC_LINK_ACTIVE_STATE},
> >  	{UFS_ACTIVE_PWR_MODE, UIC_LINK_HIBERN8_STATE},
> >  	{UFS_SLEEP_PWR_MODE, UIC_LINK_ACTIVE_STATE}, @@ -813,28
> +814,6 @@
> > static inline bool ufshcd_is_hba_active(struct ufs_hba *hba)
> >  		? false : true;
> >  }
> >
> > -static const char *ufschd_uic_link_state_to_string(
> > -			enum uic_link_state state)
> > -{
> > -	switch (state) {
> > -	case UIC_LINK_OFF_STATE:	return "OFF";
> > -	case UIC_LINK_ACTIVE_STATE:	return "ACTIVE";
> > -	case UIC_LINK_HIBERN8_STATE:	return "HIBERN8";
> > -	default:			return "UNKNOWN";
> > -	}
> > -}
> > -
> > -static const char *ufschd_ufs_dev_pwr_mode_to_string(
> > -			enum ufs_dev_pwr_mode state)
> > -{
> > -	switch (state) {
> > -	case UFS_ACTIVE_PWR_MODE:	return "ACTIVE";
> > -	case UFS_SLEEP_PWR_MODE:	return "SLEEP";
> > -	case UFS_POWERDOWN_PWR_MODE:	return "POWERDOWN";
> > -	default:			return "UNKNOWN";
> > -	}
> > -}
> > -
> >  u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)  {
> >  	/* HCI version 1.0 and 1.1 supports UniPro 1.41 */ @@ -7585,133
> > +7564,6 @@ int ufshcd_runtime_idle(struct ufs_hba *hba)  }
> > EXPORT_SYMBOL(ufshcd_runtime_idle);
> >
> > -static inline ssize_t ufshcd_pm_lvl_store(struct device *dev,
> > -					   struct device_attribute *attr,
> > -					   const char *buf, size_t count,
> > -					   bool rpm)
> > -{
> > -	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > -	unsigned long flags, value;
> > -
> > -	if (kstrtoul(buf, 0, &value))
> > -		return -EINVAL;
> > -
> > -	if (value >=3D UFS_PM_LVL_MAX)
> > -		return -EINVAL;
> > -
> > -	spin_lock_irqsave(hba->host->host_lock, flags);
> > -	if (rpm)
> > -		hba->rpm_lvl =3D value;
> > -	else
> > -		hba->spm_lvl =3D value;
> > -	spin_unlock_irqrestore(hba->host->host_lock, flags);
> > -	return count;
> > -}
> > -
> > -static ssize_t ufshcd_rpm_lvl_show(struct device *dev,
> > -		struct device_attribute *attr, char *buf)
> > -{
> > -	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > -	int curr_len;
> > -	u8 lvl;
> > -
> > -	curr_len =3D snprintf(buf, PAGE_SIZE,
> > -			    "\nCurrent Runtime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > -			    hba->rpm_lvl,
> > -			    ufschd_ufs_dev_pwr_mode_to_string(
> > -				ufs_pm_lvl_states[hba-
> >rpm_lvl].dev_state),
> > -			    ufschd_uic_link_state_to_string(
> > -				ufs_pm_lvl_states[hba-
> >rpm_lvl].link_state));
> > -
> > -	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > -			     "\nAll available Runtime PM levels info:\n");
> > -	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > -		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > -				     "\tRuntime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > -				    lvl,
> > -				    ufschd_ufs_dev_pwr_mode_to_string(
> > -					ufs_pm_lvl_states[lvl].dev_state),
> > -				    ufschd_uic_link_state_to_string(
> > -					ufs_pm_lvl_states[lvl].link_state));
> > -
> > -	return curr_len;
> > -}
> > -
> > -static ssize_t ufshcd_rpm_lvl_store(struct device *dev,
> > -		struct device_attribute *attr, const char *buf, size_t count)
> > -{
> > -	return ufshcd_pm_lvl_store(dev, attr, buf, count, true);
> > -}
> > -
> > -static void ufshcd_add_rpm_lvl_sysfs_nodes(struct ufs_hba *hba) -{
> > -	hba->rpm_lvl_attr.show =3D ufshcd_rpm_lvl_show;
> > -	hba->rpm_lvl_attr.store =3D ufshcd_rpm_lvl_store;
> > -	sysfs_attr_init(&hba->rpm_lvl_attr.attr);
> > -	hba->rpm_lvl_attr.attr.name =3D "rpm_lvl";
> > -	hba->rpm_lvl_attr.attr.mode =3D 0644;
> > -	if (device_create_file(hba->dev, &hba->rpm_lvl_attr))
> > -		dev_err(hba->dev, "Failed to create sysfs for rpm_lvl\n");
> > -}
> > -
> > -static ssize_t ufshcd_spm_lvl_show(struct device *dev,
> > -		struct device_attribute *attr, char *buf)
> > -{
> > -	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > -	int curr_len;
> > -	u8 lvl;
> > -
> > -	curr_len =3D snprintf(buf, PAGE_SIZE,
> > -			    "\nCurrent System PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > -			    hba->spm_lvl,
> > -			    ufschd_ufs_dev_pwr_mode_to_string(
> > -				ufs_pm_lvl_states[hba-
> >spm_lvl].dev_state),
> > -			    ufschd_uic_link_state_to_string(
> > -				ufs_pm_lvl_states[hba-
> >spm_lvl].link_state));
> > -
> > -	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > -			     "\nAll available System PM levels info:\n");
> > -	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > -		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > -				     "\tSystem PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > -				    lvl,
> > -				    ufschd_ufs_dev_pwr_mode_to_string(
> > -					ufs_pm_lvl_states[lvl].dev_state),
> > -				    ufschd_uic_link_state_to_string(
> > -					ufs_pm_lvl_states[lvl].link_state));
> > -
> > -	return curr_len;
> > -}
> > -
> > -static ssize_t ufshcd_spm_lvl_store(struct device *dev,
> > -		struct device_attribute *attr, const char *buf, size_t count)
> > -{
> > -	return ufshcd_pm_lvl_store(dev, attr, buf, count, false);
> > -}
> > -
> > -static void ufshcd_add_spm_lvl_sysfs_nodes(struct ufs_hba *hba) -{
> > -	hba->spm_lvl_attr.show =3D ufshcd_spm_lvl_show;
> > -	hba->spm_lvl_attr.store =3D ufshcd_spm_lvl_store;
> > -	sysfs_attr_init(&hba->spm_lvl_attr.attr);
> > -	hba->spm_lvl_attr.attr.name =3D "spm_lvl";
> > -	hba->spm_lvl_attr.attr.mode =3D 0644;
> > -	if (device_create_file(hba->dev, &hba->spm_lvl_attr))
> > -		dev_err(hba->dev, "Failed to create sysfs for spm_lvl\n");
> > -}
> > -
> > -static inline void ufshcd_add_sysfs_nodes(struct ufs_hba *hba) -{
> > -	ufshcd_add_rpm_lvl_sysfs_nodes(hba);
> > -	ufshcd_add_spm_lvl_sysfs_nodes(hba);
> > -}
> > -
> > -static inline void ufshcd_remove_sysfs_nodes(struct ufs_hba *hba) -{
> > -	device_remove_file(hba->dev, &hba->rpm_lvl_attr);
> > -	device_remove_file(hba->dev, &hba->spm_lvl_attr);
> > -}
> > -
> >  /**
> >   * ufshcd_shutdown - shutdown routine
> >   * @hba: per adapter instance
> > @@ -7749,7 +7601,7 @@ EXPORT_SYMBOL(ufshcd_shutdown);
> >   */
> >  void ufshcd_remove(struct ufs_hba *hba)  {
> > -	ufshcd_remove_sysfs_nodes(hba);
> > +	ufs_sysfs_remove_nodes(hba->dev);
> >  	scsi_remove_host(hba->host);
> >  	/* disable interrupts */
> >  	ufshcd_disable_intr(hba, hba->intr_mask); @@ -7996,7 +7848,7 @@
> int
> > ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int
> irq)
> >  	ufshcd_set_ufs_dev_active(hba);
> >
> >  	async_schedule(ufshcd_async_scan, hba);
> > -	ufshcd_add_sysfs_nodes(hba);
> > +	ufs_sysfs_add_nodes(hba->dev);
> >
> >  	return 0;
> >
> > diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> > index 1332e54..53e2779 100644
> > --- a/drivers/scsi/ufs/ufshcd.h
> > +++ b/drivers/scsi/ufs/ufshcd.h
> > @@ -985,4 +985,6 @@ static inline void
> ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
> >  		hba->vops->dbg_register_dump(hba);
> >  }
> >
> > +extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
> > +
> >  #endif /* End of Header */
> > --
> > 2.7.4
