Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D569C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8BA26637
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sTuwJ3s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8BA26637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeFZHpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:45:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbeFZHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:45:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5Q7iKpt151614;
        Tue, 26 Jun 2018 07:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=2kIqS0cF/4l0ErW6czHlvQXxX6JAzOqKQ9IrqTncaFE=;
 b=sTuwJ3s71UNlBg2Ga8FI9JBRmvlpkkpgYmZghWihtD6wv6s9ou0yEL259YL9r6c+qY+x
 AHl842lsj66y0mRxWCn0VrhhK5j98brKnmwDAIGyidrqXQhqKRD5j2DuN3fiyU6l5xZ+
 sw5BP2dQZu2qZxlZg08/U3ZXQcVMO7yyjuXeMXr1r15b3WzvnDf9iAoeJtpAbCWJL3uL
 wRg3Qk3rqZyA4ItUPxCPyVb+NLt/aDdv5ysJ98yN8B/AnD6mZ6F/DuU9V7enlBcBdTUN
 0/Pd9u4tzo+CwNMEBUtLFVMRujY62MxMUgXXx0z8j68KgIWD+RjzhqFPjldltzCw835a Bw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ju20t2s1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 07:44:45 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5Q7ii8b005649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 07:44:44 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5Q7igxq011283;
        Tue, 26 Jun 2018 07:44:42 GMT
Received: from mwanda (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 00:44:41 -0700
Date:   Tue, 26 Jun 2018 10:44:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Pingfan Liu <kernelfans@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] drivers/base: reorder consumer and its children
 behind suppliers
Message-ID: <20180626074426.hzunfbvwbubt3t3p@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ There is a bug with kbuild where it's not showing the Smatch warnings
  but I can probably guess...  - dan ]

Hi Pingfan,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/drivers-base-bugfix-for-supplier-consumer-ordering-in-device_kset/20180625-132702


# https://github.com/0day-ci/linux/commit/1b2a1e63898baf80e8e830991284e1534bc54766
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 1b2a1e63898baf80e8e830991284e1534bc54766
vim +/ret +245 drivers/base/core.c

1b2a1e63 Pingfan Liu 2018-06-25  216  
1b2a1e63 Pingfan Liu 2018-06-25  217  /* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
1b2a1e63 Pingfan Liu 2018-06-25  218   * there may be requirement to recursively move item.
1b2a1e63 Pingfan Liu 2018-06-25  219   */
1b2a1e63 Pingfan Liu 2018-06-25  220  int device_reorder_consumer(struct device *dev)
1b2a1e63 Pingfan Liu 2018-06-25  221  {
1b2a1e63 Pingfan Liu 2018-06-25  222  	struct list_head *iter, *left, *right;
1b2a1e63 Pingfan Liu 2018-06-25  223  	struct device *cur_dev;
1b2a1e63 Pingfan Liu 2018-06-25  224  	struct pos_info info;
1b2a1e63 Pingfan Liu 2018-06-25  225  	int ret, idx;
1b2a1e63 Pingfan Liu 2018-06-25  226  
1b2a1e63 Pingfan Liu 2018-06-25  227  	idx = device_links_read_lock();
1b2a1e63 Pingfan Liu 2018-06-25  228  	if (list_empty(&dev->links.suppliers)) {
1b2a1e63 Pingfan Liu 2018-06-25  229  		device_links_read_unlock(idx);
1b2a1e63 Pingfan Liu 2018-06-25  230  		return 0;
1b2a1e63 Pingfan Liu 2018-06-25  231  	}
1b2a1e63 Pingfan Liu 2018-06-25  232  	spin_lock(&devices_kset->list_lock);
1b2a1e63 Pingfan Liu 2018-06-25  233  	list_for_each_prev(iter, &devices_kset->list) {
1b2a1e63 Pingfan Liu 2018-06-25  234  		cur_dev = list_entry(iter, struct device, kobj.entry);
1b2a1e63 Pingfan Liu 2018-06-25  235  		ret = find_last_supplier(dev, cur_dev);
1b2a1e63 Pingfan Liu 2018-06-25  236  		switch (ret) {
1b2a1e63 Pingfan Liu 2018-06-25  237  		case -1:
1b2a1e63 Pingfan Liu 2018-06-25  238  			goto unlock;
1b2a1e63 Pingfan Liu 2018-06-25  239  		case 1:
1b2a1e63 Pingfan Liu 2018-06-25  240  			break;
1b2a1e63 Pingfan Liu 2018-06-25  241  		case 0:
1b2a1e63 Pingfan Liu 2018-06-25  242  			continue;

The break breaks from the switch and the continue continues the loop so
they're equivalent.  Perhaps you intended to break from the loop?

1b2a1e63 Pingfan Liu 2018-06-25  243  		}
1b2a1e63 Pingfan Liu 2018-06-25  244  	}
1b2a1e63 Pingfan Liu 2018-06-25 @245  	BUG_ON(!ret);

If the list is empty then "ret" can be unitialized.  We test a different
list "dev->links.suppliers" to see if that's empty.  I wrote a bunch of
code to make Smatch try to understand about empty lists, but I don't
think it works...

1b2a1e63 Pingfan Liu 2018-06-25  246  
1b2a1e63 Pingfan Liu 2018-06-25  247  	/* record the affected open section */
1b2a1e63 Pingfan Liu 2018-06-25  248  	left = dev->kobj.entry.prev;
1b2a1e63 Pingfan Liu 2018-06-25  249  	right = iter;
1b2a1e63 Pingfan Liu 2018-06-25  250  	info.pos = list_entry(iter, struct device, kobj.entry);
1b2a1e63 Pingfan Liu 2018-06-25  251  	info.tail = NULL;
1b2a1e63 Pingfan Liu 2018-06-25  252  	/* dry out the consumers in (left,right) */
1b2a1e63 Pingfan Liu 2018-06-25  253  	__device_reorder_consumer(dev, left, right, &info);
1b2a1e63 Pingfan Liu 2018-06-25  254  
1b2a1e63 Pingfan Liu 2018-06-25  255  unlock:
1b2a1e63 Pingfan Liu 2018-06-25  256  	spin_unlock(&devices_kset->list_lock);
1b2a1e63 Pingfan Liu 2018-06-25  257  	device_links_read_unlock(idx);
1b2a1e63 Pingfan Liu 2018-06-25  258  	return 0;
1b2a1e63 Pingfan Liu 2018-06-25  259  }
1b2a1e63 Pingfan Liu 2018-06-25  260  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
