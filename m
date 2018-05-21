Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbeEUQQY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:16:24 -0400
Received: from esa2.cray.iphmx.com ([68.232.143.164]:40288 "EHLO
        esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeEUQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:16:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,426,1520899200";
   d="scan'208";a="19652436"
X-Cray-OBMMKR: 1433258124 19652436
From: Patrick Farrell <paf@cray.com>
To: NeilBrown <neilb@suse.com>, Oleg Drokin <oleg.drokin@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lustre Development List" <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 13/30] staging: lustre: replace
 libcfs_register_ioctl with a blocking notifier_chain
Thread-Topic: [lustre-devel] [PATCH 13/30] staging: lustre: replace
 libcfs_register_ioctl with a blocking notifier_chain
Thread-Index: AQHT8L27y4mGNXipZkGr2uLdw9Um56Q6BiCA
Date: Mon, 21 May 2018 16:06:45 +0000
Message-ID: <BE6A1DEE-0CAE-4703-89C5-4722C0319BF9@cray.com>
References: <152687724799.24196.7718555295926047576.stgit@noble>
 <152687731283.24196.5413466102459843186.stgit@noble>
In-Reply-To: <152687731283.24196.5413466102459843186.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.d.0.180513
authentication-results: spf=none (sender IP is ) smtp.mailfrom=paf@cray.com; 
x-originating-ip: [136.162.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3PR1101MB1102;7:OQ9m1/tTx0vyuQKXAjwNjljOiTo4RYcDsi4swiRZetiCa43cYoN4pqKO0mgScJDKFIo+i5/3kgBRKl/TjVjKSMOQy0Gbk4Chgc+TxJRKgbOvqoAdpMe61niAuHTQGoZERYw9BTmX78ewEkhrWzCjzSKIO6APtA1TQ0omPHaEaOHhZBFMX1Ck6MKZx2vm0znjjsWY6ecwF9YbGrgTYKKfnTVUEoR2ey6VG2cvRTPmoZMDwA6bS7pMHE/dIeIJCie1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR1101MB1102;
x-ms-traffictypediagnostic: DM3PR1101MB1102:
x-microsoft-antispam-prvs: <DM3PR1101MB1102DD8BC5687936D0FD089BCB950@DM3PR1101MB1102.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM3PR1101MB1102;BCL:0;PCL:0;RULEID:;SRVR:DM3PR1101MB1102;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(39850400004)(376002)(189003)(199004)(6486002)(476003)(229853002)(8936002)(81166006)(81156014)(6246003)(8676002)(36756003)(66066001)(53936002)(7736002)(6436002)(83716003)(102836004)(575784001)(486006)(11346002)(76176011)(86362001)(186003)(82746002)(26005)(2616005)(5250100002)(6506007)(99286004)(59450400001)(446003)(14454004)(54906003)(58126008)(110136005)(25786009)(33656002)(316002)(6306002)(3846002)(6116002)(6512007)(68736007)(4326008)(3280700002)(3660700001)(2900100001)(478600001)(5660300001)(305945005)(106356001)(97736004)(105586002)(2906002)(966005)(13693001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR1101MB1102;H:DM3PR1101MB1213.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eLnC3ejRYguROMzhwTqRpJgQwYLtVnLGwktXKwEnoRKFi+U1+90QBfC4rBCZi2AAxJgXUBD757kPYSnCARQn/fN8JmgLPVjwKgpyEtKHb2Be4EtQ9Zmlr40S+yGBlrGaPBvwzN/Nqs6DCBEwGajy3klPh5FCjYPHPJa15ruxerVb/OI9wtcFl6gaalIjesji
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FCB17E47DF6B144B62A152CAD8C6A29@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8b22e933-ceff-4b90-4160-08d5bf34d9eb
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22e933-ceff-4b90-4160-08d5bf34d9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 16:06:45.6196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR1101MB1102
X-OriginatorOrg: cray.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LGGUvA019681

This, and the rest of the series, look good.  Feel free to add a Reviewed-by.

Thanks, Neil.

﻿On 5/20/18, 11:39 PM, "lustre-devel on behalf of NeilBrown" <lustre-devel-bounces@lists.lustre.org on behalf of neilb@suse.com> wrote:

    libcfs allows other modules to register handlers for ioctls.
    The implementation it uses for this is nearly identical to a
    blocking notifier chain, so change to use that.
    
    The biggest difference is that the return value from notifier has a
    defined format, where libcfs_register_ioctl uses -EINVAL to mean
    "continue".  This requires a little bit of conversion.
    
    Signed-off-by: NeilBrown <neilb@suse.com>
    ---
     .../staging/lustre/include/linux/libcfs/libcfs.h   |   19 ++----
     drivers/staging/lustre/lnet/libcfs/module.c        |   64 ++++----------------
     drivers/staging/lustre/lnet/lnet/module.c          |   38 ++++++++----
     drivers/staging/lustre/lnet/selftest/conctl.c      |   27 +++++---
     drivers/staging/lustre/lnet/selftest/console.c     |   10 ++-
     drivers/staging/lustre/lnet/selftest/console.h     |    3 +
     6 files changed, 70 insertions(+), 91 deletions(-)
    
    diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
    index d9002e7424d4..63ea0e99ec58 100644
    --- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
    +++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
    @@ -93,19 +93,14 @@
     #define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
     #define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
     
    -struct libcfs_ioctl_handler {
    -	struct list_head item;
    -	int (*handle_ioctl)(unsigned int cmd, struct libcfs_ioctl_hdr *hdr);
    -};
    -
    -#define DECLARE_IOCTL_HANDLER(ident, func)			\
    -	struct libcfs_ioctl_handler ident = {			\
    -		.item		= LIST_HEAD_INIT(ident.item),	\
    -		.handle_ioctl	= func				\
    -	}
    +extern struct blocking_notifier_head libcfs_ioctl_list;
    +static inline int notifier_from_ioctl_errno(int err)
    +{
    +	if (err == -EINVAL)
    +		return NOTIFY_OK;
    +	return notifier_from_errno(err) | NOTIFY_STOP_MASK;
    +}
     
    -int libcfs_register_ioctl(struct libcfs_ioctl_handler *hand);
    -int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand);
     int libcfs_setup(void);
     
     #define _LIBCFS_H
    diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
    index 3e51aae751c5..b3a7c1a912ba 100644
    --- a/drivers/staging/lustre/lnet/libcfs/module.c
    +++ b/drivers/staging/lustre/lnet/libcfs/module.c
    @@ -62,38 +62,8 @@
     
     static struct dentry *lnet_debugfs_root;
     
    -static DECLARE_RWSEM(ioctl_list_sem);
    -static LIST_HEAD(ioctl_list);
    -
    -int libcfs_register_ioctl(struct libcfs_ioctl_handler *hand)
    -{
    -	int rc = 0;
    -
    -	down_write(&ioctl_list_sem);
    -	if (!list_empty(&hand->item))
    -		rc = -EBUSY;
    -	else
    -		list_add_tail(&hand->item, &ioctl_list);
    -	up_write(&ioctl_list_sem);
    -
    -	return rc;
    -}
    -EXPORT_SYMBOL(libcfs_register_ioctl);
    -
    -int libcfs_deregister_ioctl(struct libcfs_ioctl_handler *hand)
    -{
    -	int rc = 0;
    -
    -	down_write(&ioctl_list_sem);
    -	if (list_empty(&hand->item))
    -		rc = -ENOENT;
    -	else
    -		list_del_init(&hand->item);
    -	up_write(&ioctl_list_sem);
    -
    -	return rc;
    -}
    -EXPORT_SYMBOL(libcfs_deregister_ioctl);
    +BLOCKING_NOTIFIER_HEAD(libcfs_ioctl_list);
    +EXPORT_SYMBOL(libcfs_ioctl_list);
     
     static inline size_t libcfs_ioctl_packlen(struct libcfs_ioctl_data *data)
     {
    @@ -268,24 +238,18 @@ static int libcfs_ioctl(unsigned long cmd, void __user *uparam)
     		libcfs_debug_mark_buffer(data->ioc_inlbuf1);
     		break;
     
    -	default: {
    -		struct libcfs_ioctl_handler *hand;
    -
    -		err = -EINVAL;
    -		down_read(&ioctl_list_sem);
    -		list_for_each_entry(hand, &ioctl_list, item) {
    -			err = hand->handle_ioctl(cmd, hdr);
    -			if (err == -EINVAL)
    -				continue;
    -
    -			if (!err) {
    -				if (copy_to_user(uparam, hdr, hdr->ioc_len))
    -					err = -EFAULT;
    -			}
    -			break;
    -		}
    -		up_read(&ioctl_list_sem);
    -		break; }
    +	default:
    +		err = blocking_notifier_call_chain(&libcfs_ioctl_list,
    +						   cmd, hdr);
    +		if (!(err & NOTIFY_STOP_MASK))
    +			/* No-one claimed the ioctl */
    +			err = -EINVAL;
    +		else
    +			err = notifier_to_errno(err);
    +		if (!err)
    +			if (copy_to_user(uparam, hdr, hdr->ioc_len))
    +				err = -EFAULT;
    +		break;
     	}
     out:
     	kvfree(hdr);
    diff --git a/drivers/staging/lustre/lnet/lnet/module.c b/drivers/staging/lustre/lnet/lnet/module.c
    index f6e912e79ca7..9d06664f0c17 100644
    --- a/drivers/staging/lustre/lnet/lnet/module.c
    +++ b/drivers/staging/lustre/lnet/lnet/module.c
    @@ -136,30 +136,37 @@ lnet_dyn_unconfigure(struct libcfs_ioctl_hdr *hdr)
     }
     
     static int
    -lnet_ioctl(unsigned int cmd, struct libcfs_ioctl_hdr *hdr)
    +lnet_ioctl(struct notifier_block *nb,
    +	   unsigned long cmd, void *vdata)
     {
     	int rc;
    +	struct libcfs_ioctl_hdr *hdr = vdata;
     
     	switch (cmd) {
     	case IOC_LIBCFS_CONFIGURE: {
     		struct libcfs_ioctl_data *data =
     			(struct libcfs_ioctl_data *)hdr;
     
    -		if (data->ioc_hdr.ioc_len < sizeof(*data))
    -			return -EINVAL;
    -
    -		the_lnet.ln_nis_from_mod_params = data->ioc_flags;
    -		return lnet_configure(NULL);
    +		if (data->ioc_hdr.ioc_len < sizeof(*data)) {
    +			rc = -EINVAL;
    +		} else {
    +			the_lnet.ln_nis_from_mod_params = data->ioc_flags;
    +			rc = lnet_configure(NULL);
    +		}
    +		break;
     	}
     
     	case IOC_LIBCFS_UNCONFIGURE:
    -		return lnet_unconfigure();
    +		rc = lnet_unconfigure();
    +		break;
     
     	case IOC_LIBCFS_ADD_NET:
    -		return lnet_dyn_configure(hdr);
    +		rc = lnet_dyn_configure(hdr);
    +		break;
     
     	case IOC_LIBCFS_DEL_NET:
    -		return lnet_dyn_unconfigure(hdr);
    +		rc = lnet_dyn_unconfigure(hdr);
    +		break;
     
     	default:
     		/*
    @@ -172,11 +179,14 @@ lnet_ioctl(unsigned int cmd, struct libcfs_ioctl_hdr *hdr)
     			rc = LNetCtl(cmd, hdr);
     			LNetNIFini();
     		}
    -		return rc;
    +		break;
     	}
    +	return notifier_from_ioctl_errno(rc);
     }
     
    -static DECLARE_IOCTL_HANDLER(lnet_ioctl_handler, lnet_ioctl);
    +static struct notifier_block lnet_ioctl_handler = {
    +	.notifier_call = lnet_ioctl,
    +};
     
     static int __init lnet_init(void)
     {
    @@ -194,7 +204,8 @@ static int __init lnet_init(void)
     		return rc;
     	}
     
    -	rc = libcfs_register_ioctl(&lnet_ioctl_handler);
    +	rc = blocking_notifier_chain_register(&libcfs_ioctl_list,
    +					      &lnet_ioctl_handler);
     	LASSERT(!rc);
     
     	if (config_on_load) {
    @@ -212,7 +223,8 @@ static void __exit lnet_exit(void)
     {
     	int rc;
     
    -	rc = libcfs_deregister_ioctl(&lnet_ioctl_handler);
    +	rc = blocking_notifier_chain_unregister(&libcfs_ioctl_list,
    +						&lnet_ioctl_handler);
     	LASSERT(!rc);
     
     	lnet_lib_exit();
    diff --git a/drivers/staging/lustre/lnet/selftest/conctl.c b/drivers/staging/lustre/lnet/selftest/conctl.c
    index a2d8092bdeb7..f22b01e390d3 100644
    --- a/drivers/staging/lustre/lnet/selftest/conctl.c
    +++ b/drivers/staging/lustre/lnet/selftest/conctl.c
    @@ -680,32 +680,34 @@ static int lst_test_add_ioctl(struct lstio_test_args *args)
     }
     
     int
    -lstcon_ioctl_entry(unsigned int cmd, struct libcfs_ioctl_hdr *hdr)
    +lstcon_ioctl_entry(struct notifier_block *nb,
    +		   unsigned long cmd, void *vdata)
     {
    -	char *buf;
    +	struct libcfs_ioctl_hdr *hdr = vdata;
    +	char *buf = NULL;
     	struct libcfs_ioctl_data *data;
     	int opc;
    -	int rc;
    +	int rc = -EINVAL;
     
     	if (cmd != IOC_LIBCFS_LNETST)
    -		return -EINVAL;
    +		goto err;
     
     	data = container_of(hdr, struct libcfs_ioctl_data, ioc_hdr);
     
     	opc = data->ioc_u32[0];
     
     	if (data->ioc_plen1 > PAGE_SIZE)
    -		return -EINVAL;
    +		goto err;
     
     	buf = kmalloc(data->ioc_plen1, GFP_KERNEL);
    +	rc = -ENOMEM;
     	if (!buf)
    -		return -ENOMEM;
    +		goto err;
     
     	/* copy in parameter */
    -	if (copy_from_user(buf, data->ioc_pbuf1, data->ioc_plen1)) {
    -		kfree(buf);
    -		return -EFAULT;
    -	}
    +	rc = -EFAULT;
    +	if (copy_from_user(buf, data->ioc_pbuf1, data->ioc_plen1))
    +		goto err;
     
     	mutex_lock(&console_session.ses_mutex);
     
    @@ -785,6 +787,7 @@ lstcon_ioctl_entry(unsigned int cmd, struct libcfs_ioctl_hdr *hdr)
     		break;
     	default:
     		rc = -EINVAL;
    +		goto out;
     	}
     
     	if (copy_to_user(data->ioc_pbuf2, &console_session.ses_trans_stat,
    @@ -792,8 +795,8 @@ lstcon_ioctl_entry(unsigned int cmd, struct libcfs_ioctl_hdr *hdr)
     		rc = -EFAULT;
     out:
     	mutex_unlock(&console_session.ses_mutex);
    -
    +err:
     	kfree(buf);
     
    -	return rc;
    +	return notifier_from_ioctl_errno(rc);
     }
    diff --git a/drivers/staging/lustre/lnet/selftest/console.c b/drivers/staging/lustre/lnet/selftest/console.c
    index 1889f1e86473..9fd6013354c6 100644
    --- a/drivers/staging/lustre/lnet/selftest/console.c
    +++ b/drivers/staging/lustre/lnet/selftest/console.c
    @@ -1996,7 +1996,9 @@ static void lstcon_init_acceptor_service(void)
     	lstcon_acceptor_service.sv_wi_total = SFW_FRWK_WI_MAX;
     }
     
    -static DECLARE_IOCTL_HANDLER(lstcon_ioctl_handler, lstcon_ioctl_entry);
    +static struct notifier_block lstcon_ioctl_handler = {
    +	.notifier_call = lstcon_ioctl_entry,
    +};
     
     /* initialize console */
     int
    @@ -2048,7 +2050,8 @@ lstcon_console_init(void)
     		goto out;
     	}
     
    -	rc = libcfs_register_ioctl(&lstcon_ioctl_handler);
    +	rc = blocking_notifier_chain_register(&libcfs_ioctl_list,
    +					      &lstcon_ioctl_handler);
     
     	if (!rc) {
     		lstcon_rpc_module_init();
    @@ -2071,7 +2074,8 @@ lstcon_console_fini(void)
     {
     	int i;
     
    -	libcfs_deregister_ioctl(&lstcon_ioctl_handler);
    +	blocking_notifier_chain_unregister(&libcfs_ioctl_list,
    +					   &lstcon_ioctl_handler);
     
     	mutex_lock(&console_session.ses_mutex);
     
    diff --git a/drivers/staging/lustre/lnet/selftest/console.h b/drivers/staging/lustre/lnet/selftest/console.h
    index 3933ed4cca93..d65b8d942bac 100644
    --- a/drivers/staging/lustre/lnet/selftest/console.h
    +++ b/drivers/staging/lustre/lnet/selftest/console.h
    @@ -187,7 +187,8 @@ lstcon_id2hash(struct lnet_process_id id, struct list_head *hash)
     	return &hash[idx];
     }
     
    -int lstcon_ioctl_entry(unsigned int cmd, struct libcfs_ioctl_hdr *hdr);
    +int lstcon_ioctl_entry(struct notifier_block *nb,
    +		       unsigned long cmd, void *vdata);
     int lstcon_console_init(void);
     int lstcon_console_fini(void);
     int lstcon_session_match(struct lst_sid sid);
    
    
    _______________________________________________
    lustre-devel mailing list
    lustre-devel@lists.lustre.org
    http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org
    
