Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD13219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hjINgDjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD13219E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeHFLYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:24:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:24:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w769E6cm021765;
        Mon, 6 Aug 2018 09:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=B16HK7edvLIgPg0+PZZZg1EASlhxdENbN4IOTE0reXI=;
 b=hjINgDjT7v8QIwjwgniYx6bUJDBaVW3M59uS5P1dNoCaTkxEm7zWuR/g6Xjne0XFuaNt
 5dd0BTtLmspKjfLTixaHFzUX/DAvcKIsmt0gDUuRKPSvbTc6YFjRY1L3QQa/T6tDRNgt
 I0RE2boWKVm3VoR66jJQMW64QlamtaDSQGGgzSVodPs61BcWQlK74fHah+Jh8InnnERi
 e3OvLEZ21WPic7v7mn2iuuyOmMspN8DzbAHArih4kCdmQpbgOktgHBv11qJphF/t7jYy
 xBHFpF80Q6FFwpkDfb6d3knT31jihkbjkiavyu/0Ns0CSQ0uIla84luCHXSjfKsYJqcc oA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kn43nky0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Aug 2018 09:15:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w769Fvxh018514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Aug 2018 09:15:57 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w769Fudi020159;
        Mon, 6 Aug 2018 09:15:56 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Aug 2018 02:15:55 -0700
Date:   Mon, 6 Aug 2018 12:15:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Sam Ravnborg <sam@ravnborg.org>
Cc:     kbuild-all@01.org, Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
Message-ID: <20180806091548.yccqipmfyymwnrvy@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802194536.10820-5-sam@ravnborg.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8976 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=942
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I love your patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Sam-Ravnborg/dt-bindings-add-parallel-data-bus-pardata/20180803-090135

smatch warnings:
drivers/gpu/drm/tinydrm/wg160160.c:145 write_buf() warn: right shifting more than type allows 8 vs 8
include/drm/tinydrm/pardata-dbi.h:165 pardata_write_buf() error: we previously assumed 'pdd' could be null (see line 162)

# https://github.com/0day-ci/linux/commit/9fcebca9e208029e06eea5e4858c1055132f06b6
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 9fcebca9e208029e06eea5e4858c1055132f06b6
vim +145 drivers/gpu/drm/tinydrm/wg160160.c

9fcebca9 Sam Ravnborg 2018-08-02  124  
9fcebca9 Sam Ravnborg 2018-08-02  125  /**
9fcebca9 Sam Ravnborg 2018-08-02  126   * write_buf - write buffer on parallel bus to controller
9fcebca9 Sam Ravnborg 2018-08-02  127   *
9fcebca9 Sam Ravnborg 2018-08-02  128   * @pdd: pardata data
9fcebca9 Sam Ravnborg 2018-08-02  129   * @offset: offset into display RAM
9fcebca9 Sam Ravnborg 2018-08-02  130   * @data: pointer to data to write
9fcebca9 Sam Ravnborg 2018-08-02  131   * @len: number of bytes to write
9fcebca9 Sam Ravnborg 2018-08-02  132   *
9fcebca9 Sam Ravnborg 2018-08-02  133   * Returns:
9fcebca9 Sam Ravnborg 2018-08-02  134   * Zero on success, negative error code on failure
9fcebca9 Sam Ravnborg 2018-08-02  135   */
9fcebca9 Sam Ravnborg 2018-08-02  136  int write_buf(struct pardata_data *pdd, u8 offset, u8 *data, size_t len)
9fcebca9 Sam Ravnborg 2018-08-02  137  {
9fcebca9 Sam Ravnborg 2018-08-02  138  	int ins[PIN_NUM];
9fcebca9 Sam Ravnborg 2018-08-02  139  	int val[PIN_NUM];
9fcebca9 Sam Ravnborg 2018-08-02  140  	int bit;
9fcebca9 Sam Ravnborg 2018-08-02  141  	int i;
9fcebca9 Sam Ravnborg 2018-08-02  142  
9fcebca9 Sam Ravnborg 2018-08-02  143  	/* Setup address */
9fcebca9 Sam Ravnborg 2018-08-02  144  	write_reg(pdd, WG160160_ADDRSL_REG, offset & 0xff);
9fcebca9 Sam Ravnborg 2018-08-02 @145  	write_reg(pdd, WG160160_ADDRSL_REG, (offset >> 8) & 0xff);
                                                                            ^^^^^^^^^^^^^^^^^^^^
Probably this is fine.  I don't know.  If so then feel free to ignore
the warning.

9fcebca9 Sam Ravnborg 2018-08-02  146  
9fcebca9 Sam Ravnborg 2018-08-02  147  	/* prepare to write data */
9fcebca9 Sam Ravnborg 2018-08-02  148  	for (i = 0; i < PIN_NUM; i++)
9fcebca9 Sam Ravnborg 2018-08-02  149  		ins[PIN_DB0 + i] = !!(WG160160_WRITE_REG & BIT(i));
9fcebca9 Sam Ravnborg 2018-08-02  150  
9fcebca9 Sam Ravnborg 2018-08-02  151  	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
9fcebca9 Sam Ravnborg 2018-08-02  152  	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
9fcebca9 Sam Ravnborg 2018-08-02  153  	wait_busy(pdd);
9fcebca9 Sam Ravnborg 2018-08-02  154  	pardata_strobe_write(pdd);
9fcebca9 Sam Ravnborg 2018-08-02  155  
9fcebca9 Sam Ravnborg 2018-08-02  156  	/* Write data byte - by byte */
9fcebca9 Sam Ravnborg 2018-08-02  157  	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
9fcebca9 Sam Ravnborg 2018-08-02  158  
9fcebca9 Sam Ravnborg 2018-08-02  159  	for (i = offset; i < (offset + len); i++) {
9fcebca9 Sam Ravnborg 2018-08-02  160  		for (bit = 0; bit < PIN_NUM; bit++)
9fcebca9 Sam Ravnborg 2018-08-02  161  			val[PIN_DB0 + bit] = !!(data[i] & BIT(bit));
9fcebca9 Sam Ravnborg 2018-08-02  162  
9fcebca9 Sam Ravnborg 2018-08-02  163  		gpiod_set_array_value_cansleep(PIN_NUM,
9fcebca9 Sam Ravnborg 2018-08-02  164  					       pdd->bus->data_pins->desc,
9fcebca9 Sam Ravnborg 2018-08-02  165  					       val);
9fcebca9 Sam Ravnborg 2018-08-02  166  		wait_busy(pdd);
9fcebca9 Sam Ravnborg 2018-08-02  167  		pardata_strobe_write(pdd);
9fcebca9 Sam Ravnborg 2018-08-02  168  	}
9fcebca9 Sam Ravnborg 2018-08-02  169  
9fcebca9 Sam Ravnborg 2018-08-02  170  	return 0;
9fcebca9 Sam Ravnborg 2018-08-02  171  }
9fcebca9 Sam Ravnborg 2018-08-02  172  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
