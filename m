Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11209C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAD820862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 04:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bX47vfvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAD820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388937AbeKGOJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 09:09:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbeKGOJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 09:09:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA74crkR024444;
        Wed, 7 Nov 2018 04:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=+iJL2K5UeOdPaT22rDfI3woY5U7/mbN5vf6/IigiSZU=;
 b=bX47vfvCxyc35pMgCvMH5K+Fh1S5gpupQvsxa4v2KiFntyhYlb118MzZ+OCS/U2FFNK6
 eNk1lJSxMU2n8pMgM1AkHr/zw66ZTqimo0saJx6mWXGnHGrFCrC07CIlxRr7LrVW9D2S
 Vv5Js0M63HCAIf/7NfJ/pvO7M7gPi0fudu/pRFNMwcXrK/nPN6oiGOZ3sDk1/sPhzj3v
 P3OSOO9pDOch5ggct9WEQptKptFwmThq1UOGpDSGugR2fW9xRyhZ1c+Ou7B9vs/hw71V
 X/GyElYUQTqd9cDq4uNPvwnj9/NvB5m87LSem0KhUBNckfwvs3ZJ+xsVuGnz9EABwdde NQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nh33u18t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 04:39:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA74dais025673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 04:39:37 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA74daLm014367;
        Wed, 7 Nov 2018 04:39:36 GMT
Received: from mwanda (/73.241.165.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 20:39:35 -0800
Date:   Wed, 7 Nov 2018 07:39:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kbuild-all@01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 4/6] drivers: base: Introducing software nodes to the
 firmware node framework
Message-ID: <20181107043933.wqszrfajrfy6hv7u@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105145928.46819-5-heikki.krogerus@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

url:    https://github.com/0day-ci/linux/commits/Heikki-Krogerus/device-property-Introducing-software-nodes/20181106-031310

smatch warnings:
drivers/base/swnode.c:391 fwnode_create_software_node() error: dereferencing freed memory 'swnode'

# https://github.com/0day-ci/linux/commit/a8c9678ea46a0171baed68e4ec355a9b3f967458
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a8c9678ea46a0171baed68e4ec355a9b3f967458
vim +/swnode +391 drivers/base/swnode.c

a8c9678e Heikki Krogerus 2018-11-05  365  
a8c9678e Heikki Krogerus 2018-11-05  366  struct fwnode_handle *
a8c9678e Heikki Krogerus 2018-11-05  367  fwnode_create_software_node(const struct property_entry *properties,
a8c9678e Heikki Krogerus 2018-11-05  368  			    const struct fwnode_handle *parent)
a8c9678e Heikki Krogerus 2018-11-05  369  {
a8c9678e Heikki Krogerus 2018-11-05  370  	struct software_node *p = NULL;
a8c9678e Heikki Krogerus 2018-11-05  371  	struct software_node *swnode;
a8c9678e Heikki Krogerus 2018-11-05  372  	char node_name[20];
a8c9678e Heikki Krogerus 2018-11-05  373  	int ret;
a8c9678e Heikki Krogerus 2018-11-05  374  
a8c9678e Heikki Krogerus 2018-11-05  375  	if (parent) {
a8c9678e Heikki Krogerus 2018-11-05  376  		if (IS_ERR(parent))
a8c9678e Heikki Krogerus 2018-11-05  377  			return ERR_CAST(parent);
a8c9678e Heikki Krogerus 2018-11-05  378  		if (!is_software_node(parent))
a8c9678e Heikki Krogerus 2018-11-05  379  			return ERR_PTR(-EINVAL);
a8c9678e Heikki Krogerus 2018-11-05  380  		p = to_software_node(parent);
a8c9678e Heikki Krogerus 2018-11-05  381  	}
a8c9678e Heikki Krogerus 2018-11-05  382  
a8c9678e Heikki Krogerus 2018-11-05  383  	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
a8c9678e Heikki Krogerus 2018-11-05  384  	if (!swnode)
a8c9678e Heikki Krogerus 2018-11-05  385  		return ERR_PTR(-ENOMEM);
a8c9678e Heikki Krogerus 2018-11-05  386  
a8c9678e Heikki Krogerus 2018-11-05  387  	swnode->id = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
a8c9678e Heikki Krogerus 2018-11-05  388  				    GFP_KERNEL);
a8c9678e Heikki Krogerus 2018-11-05  389  	if (swnode->id < 0) {
a8c9678e Heikki Krogerus 2018-11-05  390  		kfree(swnode);
                                                              ^^^^^^
a8c9678e Heikki Krogerus 2018-11-05 @391  		return ERR_PTR(swnode->id);
                                                                       ^^^^^^^^^^
a8c9678e Heikki Krogerus 2018-11-05  392  	}
a8c9678e Heikki Krogerus 2018-11-05  393  
a8c9678e Heikki Krogerus 2018-11-05  394  	sprintf(node_name, "node%d", swnode->id);
a8c9678e Heikki Krogerus 2018-11-05  395  
a8c9678e Heikki Krogerus 2018-11-05  396  	swnode->kobj.kset = swnode_kset;
a8c9678e Heikki Krogerus 2018-11-05  397  	swnode->fwnode.ops = &software_node_ops;
a8c9678e Heikki Krogerus 2018-11-05  398  
a8c9678e Heikki Krogerus 2018-11-05  399  	ida_init(&swnode->child_ids);
a8c9678e Heikki Krogerus 2018-11-05  400  	INIT_LIST_HEAD(&swnode->entry);
a8c9678e Heikki Krogerus 2018-11-05  401  	INIT_LIST_HEAD(&swnode->children);
a8c9678e Heikki Krogerus 2018-11-05  402  	swnode->parent = p;
a8c9678e Heikki Krogerus 2018-11-05  403  
a8c9678e Heikki Krogerus 2018-11-05  404  	if (p)
a8c9678e Heikki Krogerus 2018-11-05  405  		list_add_tail(&swnode->entry, &p->children);
a8c9678e Heikki Krogerus 2018-11-05  406  
a8c9678e Heikki Krogerus 2018-11-05  407  	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
a8c9678e Heikki Krogerus 2018-11-05  408  				   p ? &p->kobj : NULL, node_name);
a8c9678e Heikki Krogerus 2018-11-05  409  	if (ret) {
a8c9678e Heikki Krogerus 2018-11-05  410  		kobject_put(&swnode->kobj);
a8c9678e Heikki Krogerus 2018-11-05  411  		return ERR_PTR(ret);
a8c9678e Heikki Krogerus 2018-11-05  412  	}
a8c9678e Heikki Krogerus 2018-11-05  413  
a8c9678e Heikki Krogerus 2018-11-05  414  	ret = software_node_register_properties(swnode, properties);
a8c9678e Heikki Krogerus 2018-11-05  415  	if (ret) {
a8c9678e Heikki Krogerus 2018-11-05  416  		kobject_put(&swnode->kobj);
a8c9678e Heikki Krogerus 2018-11-05  417  		return ERR_PTR(ret);
a8c9678e Heikki Krogerus 2018-11-05  418  	}
a8c9678e Heikki Krogerus 2018-11-05  419  
a8c9678e Heikki Krogerus 2018-11-05  420  	kobject_uevent(&swnode->kobj, KOBJ_ADD);
a8c9678e Heikki Krogerus 2018-11-05  421  	return &swnode->fwnode;
a8c9678e Heikki Krogerus 2018-11-05  422  }
a8c9678e Heikki Krogerus 2018-11-05  423  EXPORT_SYMBOL_GPL(fwnode_create_software_node);
a8c9678e Heikki Krogerus 2018-11-05  424  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
