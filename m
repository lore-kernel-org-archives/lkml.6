Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757272AbeD0BZP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:25:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:25640 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754824AbeD0BZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:25:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,333,1520924400";
   d="scan'208";a="44938565"
Date: Fri, 27 Apr 2018 09:24:21 +0800
From: kbuild test robot <lkp@intel.com>
To: Chris Lew <clew@codeaurora.org>
Cc: kbuild-all@01.org, bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        clew@codeaurora.org
Subject: Re: [PATCH v2 6/6] rpmsg: glink: Expose rpmsg name attr for glink
Message-ID: <201804270908.gvoFdL1v%fengguang.wu@intel.com>
References: <1524708472-18263-7-git-send-email-clew@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524708472-18263-7-git-send-email-clew@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chris-Lew/Add-chrdev-and-name-query-support-for-GLINK/20180427-023202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/rpmsg/qcom_glink_native.c:624:16: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] id @@    got  short [unsigned] [usertype] id @@
   drivers/rpmsg/qcom_glink_native.c:624:16:    expected unsigned short [unsigned] [usertype] id
   drivers/rpmsg/qcom_glink_native.c:624:16:    got restricted __le16 [usertype] <noident>
   drivers/rpmsg/qcom_glink_native.c:625:18: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] lcid @@    got  short [unsigned] [usertype] lcid @@
   drivers/rpmsg/qcom_glink_native.c:625:18:    expected unsigned short [unsigned] [usertype] lcid
   drivers/rpmsg/qcom_glink_native.c:625:18:    got restricted __le16 [usertype] <noident>
   drivers/rpmsg/qcom_glink_native.c:626:19: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] count @@    got ed int [unsigned] [usertype] count @@
   drivers/rpmsg/qcom_glink_native.c:626:19:    expected unsigned int [unsigned] [usertype] count
   drivers/rpmsg/qcom_glink_native.c:626:19:    got restricted __le32 [usertype] <noident>
   drivers/rpmsg/qcom_glink_native.c:627:18: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] size @@    got ed int [unsigned] [usertype] size @@
   drivers/rpmsg/qcom_glink_native.c:627:18:    expected unsigned int [unsigned] [usertype] size
   drivers/rpmsg/qcom_glink_native.c:627:18:    got restricted __le32 [usertype] <noident>
   drivers/rpmsg/qcom_glink_native.c:628:18: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [unsigned] [usertype] liid @@    got ed int [unsigned] [usertype] liid @@
   drivers/rpmsg/qcom_glink_native.c:628:18:    expected unsigned int [unsigned] [usertype] liid
   drivers/rpmsg/qcom_glink_native.c:628:18:    got restricted __le32 [usertype] <noident>
>> drivers/rpmsg/qcom_glink_native.c:1569:1: sparse: incorrect type in initializer (different modifiers) @@    expected struct attribute **attrs @@    got structstruct attribute **attrs @@
   drivers/rpmsg/qcom_glink_native.c:1569:1:    expected struct attribute **attrs
   drivers/rpmsg/qcom_glink_native.c:1569:1:    got struct attribute const **<noident>
   In file included from include/linux/kobject.h:20:0,
                    from include/linux/irqdesc.h:6,
                    from include/linux/irq.h:517,
                    from arch/x86/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from drivers/rpmsg/qcom_glink_native.c:15:
   drivers/rpmsg/qcom_glink_native.c:1569:18: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    ATTRIBUTE_GROUPS(qcom_glink);
                     ^
   include/linux/sysfs.h:154:11: note: in definition of macro 'ATTRIBUTE_GROUPS'
     .attrs = _name##_attrs,     31-           ^~~~~
   drivers/rpmsg/qcom_glink_native.c:1569:18: note: (near initialization for 'qcom_glink_group.attrs')
    ATTRIBUTE_GROUPS(qcom_glink);
                     ^
   include/linux/sysfs.h:154:11: note: in definition of macro 'ATTRIBUTE_GROUPS'
     .attrs = _name##_attrs,     37-           ^~~~~
   cc1: some warnings being treated as errors

vim +1569 drivers/rpmsg/qcom_glink_native.c

  1564	
  1565	static const struct attribute *qcom_glink_attrs[] = {
  1566		&dev_attr_rpmsg_name.attr,
  1567		NULL
  1568	};
> 1569	ATTRIBUTE_GROUPS(qcom_glink);
  1570	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
