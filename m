Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38388C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8FA2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8FA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755736AbeFOFpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:45:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:40576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755691AbeFOFoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:44:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 22:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237351600"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2018 22:44:53 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fThXY-0007Tf-G6; Fri, 15 Jun 2018 13:44:52 +0800
Date:   Fri, 15 Jun 2018 13:44:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     linux-scsi-owner@vger.kernel.org
Cc:     kbuild-all@01.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scsi: xen-scsifront: add error handling for
 xenbus_printf
Message-ID: <201806151305.MldLqVQQ%fengguang.wu@intel.com>
References: <1529017154-54719-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529017154-54719-1-git-send-email-jiazhouyang09@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xen-tip/linux-next]
[also build test WARNING on v4.17 next-20180614]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/linux-scsi-owner-vger-kernel-org/scsi-xen-scsifront-add-error-handling-for-xenbus_printf/20180615-070404
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git linux-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/scsi/xen-scsifront.c:267:21: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:440:33: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:440:33: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:473:33: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:473:33: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:474:33: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:474:33: sparse: expression using sizeof(void)
>> drivers/scsi/xen-scsifront.c:663:47: sparse: incorrect type in argument 1 (different base types) @@    expected struct xenbus_device *dev @@    got xenbus_device *dev @@
   drivers/scsi/xen-scsifront.c:663:47:    expected struct xenbus_device *dev
   drivers/scsi/xen-scsifront.c:663:47:    got struct device *<noident>
   drivers/scsi/xen-scsifront.c:681:47: sparse: incorrect type in argument 1 (different base types) @@    expected struct xenbus_device *dev @@    got xenbus_device *dev @@
   drivers/scsi/xen-scsifront.c:681:47:    expected struct xenbus_device *dev
   drivers/scsi/xen-scsifront.c:681:47:    got struct device *<noident>
   drivers/scsi/xen-scsifront.c:1022:59: sparse: incorrect type in argument 1 (different base types) @@    expected struct xenbus_device *dev @@    got xenbus_device *dev @@
   drivers/scsi/xen-scsifront.c:1022:59:    expected struct xenbus_device *dev
   drivers/scsi/xen-scsifront.c:1022:59:    got struct device *<noident>
   drivers/scsi/xen-scsifront.c:1042:59: sparse: incorrect type in argument 1 (different base types) @@    expected struct xenbus_device *dev @@    got xenbus_device *dev @@
   drivers/scsi/xen-scsifront.c:1042:59:    expected struct xenbus_device *dev
   drivers/scsi/xen-scsifront.c:1042:59:    got struct device *<noident>
   drivers/scsi/xen-scsifront.c:1063:19: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:1064:19: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c:1065:19: sparse: expression using sizeof(void)
   drivers/scsi/xen-scsifront.c: In function 'scsifront_sdev_configure':
   drivers/scsi/xen-scsifront.c:663:21: error: passing argument 1 of 'xenbus_dev_error' from incompatible pointer type [-Werror=incompatible-pointer-types]
       xenbus_dev_error(&info->dev->dev, err,
                        ^
   In file included from drivers/scsi/xen-scsifront.c:50:0:
   include/xen/xenbus.h:224:6: note: expected 'struct xenbus_device *' but argument is of type 'struct device *'
    void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
         ^~~~~~~~~~~~~~~~
   drivers/scsi/xen-scsifront.c: In function 'scsifront_sdev_destroy':
   drivers/scsi/xen-scsifront.c:681:21: error: passing argument 1 of 'xenbus_dev_error' from incompatible pointer type [-Werror=incompatible-pointer-types]
       xenbus_dev_error(&info->dev->dev, err,
                        ^
   In file included from drivers/scsi/xen-scsifront.c:50:0:
   include/xen/xenbus.h:224:6: note: expected 'struct xenbus_device *' but argument is of type 'struct device *'
    void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
         ^~~~~~~~~~~~~~~~
   drivers/scsi/xen-scsifront.c: In function 'scsifront_do_lun_hotplug':
   drivers/scsi/xen-scsifront.c:1022:23: error: passing argument 1 of 'xenbus_dev_error' from incompatible pointer type [-Werror=incompatible-pointer-types]
         xenbus_dev_error(&dev->dev, err,
                          ^
   In file included from drivers/scsi/xen-scsifront.c:50:0:
   include/xen/xenbus.h:224:6: note: expected 'struct xenbus_device *' but argument is of type 'struct device *'
    void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
         ^~~~~~~~~~~~~~~~
   drivers/scsi/xen-scsifront.c:1042:23: error: passing argument 1 of 'xenbus_dev_error' from incompatible pointer type [-Werror=incompatible-pointer-types]
         xenbus_dev_error(&dev->dev, err,
                          ^
   In file included from drivers/scsi/xen-scsifront.c:50:0:
   include/xen/xenbus.h:224:6: note: expected 'struct xenbus_device *' but argument is of type 'struct device *'
    void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +663 drivers/scsi/xen-scsifront.c

   653	
   654	static int scsifront_sdev_configure(struct scsi_device *sdev)
   655	{
   656		struct vscsifrnt_info *info = shost_priv(sdev->host);
   657		int err;
   658	
   659		if (info && current == info->curr) {
   660			err = xenbus_printf(XBT_NIL, info->dev->nodename,
   661				      info->dev_state_path, "%d", XenbusStateConnected);
   662			if (err) {
 > 663				xenbus_dev_error(&info->dev->dev, err,
   664					"%s: writing dev_state_path", __func__);
   665				return err;
   666			}
   667		}
   668	
   669		return 0;
   670	}
   671	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
