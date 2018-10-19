Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4C62086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qp87nx8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4C62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeJSPDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:03:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJSPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:03:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J6hoKc008051;
        Fri, 19 Oct 2018 06:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=MhUMVM3LmkFtbZ90mXzL3UpE7iXgF0OVUvkcxo87VRw=;
 b=qp87nx8J6TJpYczz5bYbIkaxIQVduM7SsAA1BPpTx8wioZhjB7ofLf5lsFJ8GYsfFwb7
 QciVHgUHylHuF4qxy5udxMJxjlTvc1s8sDTwtQOTiZKe6+c+Vc9myv/Vdo7B8H3Opj05
 anENFmYLMHrqAP+Gq/sIgwYJNSiCab8dp3rq/d4vecXAb2l/NsaIgM6gn7oY3cyQOBrW
 72C3KnNlaIkdPDxJhbHMhIcycDMkV+fw/1r+OnoNYidXaRb5BS7LDW0FpqAPV5R1GiGg
 BQ3YvBi/XUs4eaYIcD9Xk/3CNxLSdy0V3h+qMnKB1/DUmGEGeNKZPnVusPuaBDkwx5/E 3A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n39brt9e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 06:58:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J6w9mU006584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 06:58:09 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J6w8b3002461;
        Fri, 19 Oct 2018 06:58:08 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 23:58:08 -0700
Date:   Fri, 19 Oct 2018 09:58:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Marcin Ciupak <marcin.s.ciupak@gmail.com>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: nrf24: add new driver for 2.4GHz radio
 transceiver
Message-ID: <20181019065801.vp6nmaodt7n7qyqh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017110001.65pcxebwsirsclim@metis.ciupak.eu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Marcin-Ciupak/staging-nrf24-add-new-driver-for-2-4GHz-radio-transceiver/20181018-164230

smatch warnings:
drivers/staging/nrf24/nrf24_if.c:538 nrf24_create_pipe() error: 'p->dev' dereferencing possible ERR_PTR()
drivers/staging/nrf24/nrf24_if.c:753 nrf24_probe() error: 'device' dereferencing possible ERR_PTR()
drivers/staging/nrf24/nrf24_sysfs.c:118 plw_store() warn: impossible condition '(old < 0) => (0-255 < 0)'

# https://github.com/0day-ci/linux/commit/f4952b4a228f4dc0149a814630c94e0e87a9f473
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f4952b4a228f4dc0149a814630c94e0e87a9f473
vim +538 drivers/staging/nrf24/nrf24_if.c

f4952b4a Marcin Ciupak 2018-10-17  503  
f4952b4a Marcin Ciupak 2018-10-17  504  static struct nrf24_pipe *nrf24_create_pipe(struct nrf24_device *device, int id)
f4952b4a Marcin Ciupak 2018-10-17  505  {
f4952b4a Marcin Ciupak 2018-10-17  506  	int ret;
f4952b4a Marcin Ciupak 2018-10-17  507  	struct nrf24_pipe *p;
f4952b4a Marcin Ciupak 2018-10-17  508  
f4952b4a Marcin Ciupak 2018-10-17  509  	//sets flags to false as well
f4952b4a Marcin Ciupak 2018-10-17  510  	p = kzalloc(sizeof(*p), GFP_KERNEL);
f4952b4a Marcin Ciupak 2018-10-17  511  	if (!p) {
f4952b4a Marcin Ciupak 2018-10-17  512  		ret = -ENOMEM;
f4952b4a Marcin Ciupak 2018-10-17  513  		goto err_return;
f4952b4a Marcin Ciupak 2018-10-17  514  	}
f4952b4a Marcin Ciupak 2018-10-17  515  
f4952b4a Marcin Ciupak 2018-10-17  516  	ret = ida_simple_get(&nrf24_ida_pipe, 0, 0, GFP_KERNEL);
f4952b4a Marcin Ciupak 2018-10-17  517  	if (ret < 0) {
f4952b4a Marcin Ciupak 2018-10-17  518  		dev_err(&device->dev, "%s: get_minor failed\n", __func__);
f4952b4a Marcin Ciupak 2018-10-17  519  		goto err_free_mem;
f4952b4a Marcin Ciupak 2018-10-17  520  	}
f4952b4a Marcin Ciupak 2018-10-17  521  
f4952b4a Marcin Ciupak 2018-10-17  522  	p->devt = MKDEV(MAJOR(nrf24_dev), ret);
f4952b4a Marcin Ciupak 2018-10-17  523  	p->id = id;
f4952b4a Marcin Ciupak 2018-10-17  524  
f4952b4a Marcin Ciupak 2018-10-17  525  	INIT_KFIFO(p->rx_fifo);
f4952b4a Marcin Ciupak 2018-10-17  526  	init_waitqueue_head(&p->poll_wait_queue);
f4952b4a Marcin Ciupak 2018-10-17  527  
f4952b4a Marcin Ciupak 2018-10-17  528  	p->dev = device_create_with_groups(nrf24_class,
f4952b4a Marcin Ciupak 2018-10-17  529  					   &device->dev,
f4952b4a Marcin Ciupak 2018-10-17  530  					   p->devt,
f4952b4a Marcin Ciupak 2018-10-17  531  					   p,
f4952b4a Marcin Ciupak 2018-10-17  532  					   nrf24_pipe_groups,
f4952b4a Marcin Ciupak 2018-10-17  533  					   "%s.%d",
f4952b4a Marcin Ciupak 2018-10-17  534  					   dev_name(&device->dev),
f4952b4a Marcin Ciupak 2018-10-17  535  					   id);
f4952b4a Marcin Ciupak 2018-10-17  536  
f4952b4a Marcin Ciupak 2018-10-17  537  	if (IS_ERR(p->dev)) {
f4952b4a Marcin Ciupak 2018-10-17 @538  		dev_err(&device->dev,
f4952b4a Marcin Ciupak 2018-10-17  539  			"%s: device_create of '%s' failed\n",
f4952b4a Marcin Ciupak 2018-10-17  540  			__func__,
f4952b4a Marcin Ciupak 2018-10-17  541  			dev_name(p->dev));
f4952b4a Marcin Ciupak 2018-10-17  542  		ret = PTR_ERR(p->dev);
f4952b4a Marcin Ciupak 2018-10-17  543  		goto err_ida_remove;
f4952b4a Marcin Ciupak 2018-10-17  544  	}
f4952b4a Marcin Ciupak 2018-10-17  545  
f4952b4a Marcin Ciupak 2018-10-17  546  	cdev_init(&p->cdev, &nrf24_fops);
f4952b4a Marcin Ciupak 2018-10-17  547  	p->cdev.owner = THIS_MODULE;
f4952b4a Marcin Ciupak 2018-10-17  548  	ret = cdev_add(&p->cdev, p->devt, 1);
f4952b4a Marcin Ciupak 2018-10-17  549  	if (ret < 0) {
f4952b4a Marcin Ciupak 2018-10-17  550  		dev_err(&device->dev, "%s: cdev failed\n", __func__);
f4952b4a Marcin Ciupak 2018-10-17  551  		goto err_dev_destroy;
f4952b4a Marcin Ciupak 2018-10-17  552  	}
f4952b4a Marcin Ciupak 2018-10-17  553  
f4952b4a Marcin Ciupak 2018-10-17  554  	dev_dbg(&device->dev,
f4952b4a Marcin Ciupak 2018-10-17  555  		"%s: device created: major(%d), minor(%d)\n",
f4952b4a Marcin Ciupak 2018-10-17  556  		__func__,
f4952b4a Marcin Ciupak 2018-10-17  557  		MAJOR(p->devt),
f4952b4a Marcin Ciupak 2018-10-17  558  		MINOR(p->devt));
f4952b4a Marcin Ciupak 2018-10-17  559  
f4952b4a Marcin Ciupak 2018-10-17  560  	return p;
f4952b4a Marcin Ciupak 2018-10-17  561  
f4952b4a Marcin Ciupak 2018-10-17  562  err_dev_destroy:
f4952b4a Marcin Ciupak 2018-10-17  563  	device_destroy(nrf24_class, p->devt);
f4952b4a Marcin Ciupak 2018-10-17  564  err_ida_remove:
f4952b4a Marcin Ciupak 2018-10-17  565  	ida_simple_remove(&nrf24_ida_pipe, MINOR(p->devt));
f4952b4a Marcin Ciupak 2018-10-17  566  err_free_mem:
f4952b4a Marcin Ciupak 2018-10-17  567  	kfree(p);
f4952b4a Marcin Ciupak 2018-10-17  568  err_return:
f4952b4a Marcin Ciupak 2018-10-17  569  	return ERR_PTR(ret);
f4952b4a Marcin Ciupak 2018-10-17  570  }
f4952b4a Marcin Ciupak 2018-10-17  571  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
