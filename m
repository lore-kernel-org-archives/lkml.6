Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174ECC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B722148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeLZUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:51:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:5997 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeLZUvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:51:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 12:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,401,1539673200"; 
   d="gz'50?scan'50,208,50";a="286816647"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2018 12:50:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gcG8U-000D3O-SP; Thu, 27 Dec 2018 04:50:38 +0800
Date:   Thu, 27 Dec 2018 04:50:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Elie Morisse <syniurge@gmail.com>
Cc:     kbuild-all@01.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, helgaas@kernel.org
Subject: Re: [PATCH v14] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Message-ID: <201812270448.WndSIprd%fengguang.wu@intel.com>
References: <20181222170052.GA8049@syn-yoga530>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20181222170052.GA8049@syn-yoga530>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elie,

I love your patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.20 next-20181224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Elie-Morisse/i2c-Add-drivers-for-the-AMD-PCIe-MP2-I2C-controller/20181223-034458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: i386-randconfig-x013-12261115 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/i2c/busses/i2c-amd-mp2-plat.c: In function 'i2c_amd_probe':
>> drivers/i2c/busses/i2c-amd-mp2-plat.c:294:17: error: 'struct amd_i2c_common' has no member named 'suspend'
     i2c_dev->common.suspend = &i2c_amd_suspend;
                    ^
>> drivers/i2c/busses/i2c-amd-mp2-plat.c:294:29: error: 'i2c_amd_suspend' undeclared (first use in this function); did you mean 'i2c_amd_func'?
     i2c_dev->common.suspend = &i2c_amd_suspend;
                                ^~~~~~~~~~~~~~~
                                i2c_amd_func
   drivers/i2c/busses/i2c-amd-mp2-plat.c:294:29: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/i2c/busses/i2c-amd-mp2-plat.c:295:18: error: 'struct amd_i2c_common' has no member named 'resume'; did you mean 'reqcmd'?
     i2c_dev->common.resume = &i2c_amd_resume;
                     ^~~~~~
                     reqcmd
>> drivers/i2c/busses/i2c-amd-mp2-plat.c:295:28: error: 'i2c_amd_resume' undeclared (first use in this function); did you mean 'i2c_amd_probe'?
     i2c_dev->common.resume = &i2c_amd_resume;
                               ^~~~~~~~~~~~~~
                               i2c_amd_probe

vim +294 drivers/i2c/busses/i2c-amd-mp2-plat.c

   263	
   264	static int i2c_amd_probe(struct platform_device *pdev)
   265	{
   266		int ret;
   267		struct amd_i2c_dev *i2c_dev;
   268		acpi_handle handle = ACPI_HANDLE(&pdev->dev);
   269		struct acpi_device *adev;
   270		struct amd_mp2_dev *mp2_dev;
   271		const char *uid;
   272	
   273		if (acpi_bus_get_device(handle, &adev))
   274			return -ENODEV;
   275	
   276		/* The ACPI namespace doesn't contain information about which MP2 PCI
   277		 * device an AMDI0011 ACPI device is related to, so assume that there's
   278		 * only one MP2 PCI device per system.
   279		 */
   280		mp2_dev = amd_mp2_find_device();
   281		if (!mp2_dev)
   282			/* The MP2 PCI device might get probed later */
   283			return -EPROBE_DEFER;
   284	
   285		i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
   286		if (!i2c_dev)
   287			return -ENOMEM;
   288	
   289		i2c_dev->common.mp2_dev = mp2_dev;
   290		i2c_dev->pdev = pdev;
   291		platform_set_drvdata(pdev, i2c_dev);
   292	
   293		i2c_dev->common.cmd_completion = &i2c_amd_cmd_completion;
 > 294		i2c_dev->common.suspend = &i2c_amd_suspend;
 > 295		i2c_dev->common.resume = &i2c_amd_resume;
   296	
   297		uid = adev->pnp.unique_id;
   298		if (!uid) {
   299			dev_err(&pdev->dev, "missing UID/bus id!\n");
   300			return -EINVAL;
   301		} else if (strcmp(uid, "0") == 0) {
   302			i2c_dev->common.bus_id = 0;
   303		} else if (strcmp(uid, "1") == 0) {
   304			i2c_dev->common.bus_id = 1;
   305		} else {
   306			dev_err(&pdev->dev, "incorrect UID/bus id \"%s\"!\n", uid);
   307			return -EINVAL;
   308		}
   309		dev_dbg(&pdev->dev, "bus id is %u\n", i2c_dev->common.bus_id);
   310	
   311		/* Register the adapter */
   312		amd_mp2_pm_runtime_get(mp2_dev);
   313	
   314		i2c_dev->common.reqcmd = i2c_none;
   315		if (amd_mp2_register_cb(&i2c_dev->common))
   316			return -EINVAL;
   317		device_link_add(&i2c_dev->pdev->dev, &mp2_dev->pci_dev->dev,
   318				DL_FLAG_AUTOREMOVE_CONSUMER);
   319	
   320		i2c_dev->common.i2c_speed = i2c_amd_get_bus_speed(pdev);
   321	
   322		/* Setup i2c adapter description */
   323		i2c_dev->adap.owner = THIS_MODULE;
   324		i2c_dev->adap.algo = &i2c_amd_algorithm;
   325		i2c_dev->adap.quirks = &amd_i2c_dev_quirks;
   326		i2c_dev->adap.dev.parent = &pdev->dev;
   327		i2c_dev->adap.algo_data = i2c_dev;
   328		i2c_dev->adap.nr = pdev->id;
   329		i2c_dev->adap.timeout = AMD_I2C_TIMEOUT;
   330		ACPI_COMPANION_SET(&i2c_dev->adap.dev, ACPI_COMPANION(&pdev->dev));
   331		i2c_dev->adap.dev.of_node = pdev->dev.of_node;
   332		snprintf(i2c_dev->adap.name, sizeof(i2c_dev->adap.name),
   333			 "AMD MP2 i2c bus %u", i2c_dev->common.bus_id);
   334		i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
   335	
   336		init_completion(&i2c_dev->cmd_complete);
   337	
   338		/* Enable the bus */
   339		if (i2c_amd_enable_set(i2c_dev, true))
   340			dev_err(&pdev->dev, "initial bus enable failed\n");
   341	
   342		/* Attach to the i2c layer */
   343		ret = i2c_add_numbered_adapter(&i2c_dev->adap);
   344	
   345		amd_mp2_pm_runtime_put(mp2_dev);
   346	
   347		if (ret < 0)
   348			dev_err(&pdev->dev, "i2c add adapter failed = %d\n", ret);
   349	
   350		return ret;
   351	}
   352	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zhXaljGHf11kAtnf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
oKLN0Y3NVOJqcXJo8AcazW2rFoUBAA==

--zhXaljGHf11kAtnf--
