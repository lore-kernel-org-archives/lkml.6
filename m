Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B345C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AD921535
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mejkb0XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AD921535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeHMAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 20:49:41 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53004 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeHMAtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 20:49:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7CMA5Ag146216;
        Sun, 12 Aug 2018 22:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=8Znf/3ZfUB/+uHimRnZZFt7aNArsaZz/wtMOaHHW1m4=;
 b=mejkb0XM+jEasnaALK6FJUdmYcOMihIkmVOFlB9pVHoP/GPg/O1ts/UW+gy9eFyRSY8C
 FRdyZ/dw0esQvB6XUzSIdcQEQ4gdc6csL9CtA8L6zMBbgythptSz5//zuRBoibhM+xIp
 jE8QCUh1eri1eHWmiukx76rCzMxszZ+0TqyL3OBDy5nAhz1Zr25ie+ynTFTqAXz+uCvC
 N44jflQg/pvKG5A8Wt8fTt2+x2z+DxT13u9mdPl+JthoKPW43yaAdNO6JYdVBwM8GT1O
 dvj6+tiqIm1ne0Q9irckf566DYTtLbizKVWIl2n+kRtuJx6Sl3iDwI0p0H4XJaMfEHXz tA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ksnact9kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 22:10:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7CMA4Sr026909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Aug 2018 22:10:05 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7CMA36J001003;
        Sun, 12 Aug 2018 22:10:03 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Aug 2018 15:10:03 -0700
Date:   Mon, 13 Aug 2018 01:09:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, zhong jiang <zhongjiang@huawei.com>
Cc:     kbuild-all@01.org, davem@davemloft.net, edumazet@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/usb/r8152: change rtl8152_system_suspend to
 be void function
Message-ID: <20180812220956.6lkusjdo2gv7x22n@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533738407-10495-1-git-send-email-zhongjiang@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808120247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhong,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/zhong-jiang/drivers-net-usb-r8152-change-rtl8152_system_suspend-to-be-void-function/20180809-111737

New smatch warnings:
drivers/net/usb/r8152.c:4447 rtl8152_suspend() error: uninitialized symbol 'ret'.

Old smatch warnings:
drivers/net/usb/r8152.c:4660 rtl8152_get_strings() error: memcpy() '*rtl8152_gstrings' too small (32 vs 416)

# https://github.com/0day-ci/linux/commit/31b61d6a0989c067332fa1ae07055b3e406c17cd
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 31b61d6a0989c067332fa1ae07055b3e406c17cd
vim +/ret +4447 drivers/net/usb/r8152.c

8fb280616 hayeswang   2017-01-10  4432  
8fb280616 hayeswang   2017-01-10  4433  static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
8fb280616 hayeswang   2017-01-10  4434  {
8fb280616 hayeswang   2017-01-10  4435  	struct r8152 *tp = usb_get_intfdata(intf);
8fb280616 hayeswang   2017-01-10  4436  	int ret;
8fb280616 hayeswang   2017-01-10  4437  
8fb280616 hayeswang   2017-01-10  4438  	mutex_lock(&tp->control);
8fb280616 hayeswang   2017-01-10  4439  
8fb280616 hayeswang   2017-01-10  4440  	if (PMSG_IS_AUTO(message))
a9c54ad2c hayeswang   2017-01-25  4441  		ret = rtl8152_runtime_suspend(tp);
8fb280616 hayeswang   2017-01-10  4442  	else
31b61d6a0 zhong jiang 2018-08-08  4443  		rtl8152_system_suspend(tp);
8fb280616 hayeswang   2017-01-10  4444  
b54032736 hayeswang   2014-10-09  4445  	mutex_unlock(&tp->control);
b54032736 hayeswang   2014-10-09  4446  
6cc69f2a4 hayeswang   2014-10-17 @4447  	return ret;
ac718b693 hayeswang   2013-05-02  4448  }
ac718b693 hayeswang   2013-05-02  4449  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
