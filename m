Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC0CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A266920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T5PwOyCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A266920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbeLFMlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:41:35 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54244 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:41:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB6Cd6nm106248;
        Thu, 6 Dec 2018 12:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=L4+uKWKf0GfoG4mbTgvZPP6iRW6WZ376ArCNhULER6s=;
 b=T5PwOyCSH8jB6SDuqC6YqsE0G/JUxIZz/MygYdf+0MQbvzkVsSyyIr9ANEty4NA/GjKY
 wCqiaiCgmGpSjyMP5IMk7oWr839hdn1ns40OBK8+mO6MhSxAD55v7MAtwQQdnS1614T/
 mX5Y8ukjqLoPI9+w9cZd/HhBqCFB1u9+xj04VwJyo6QGsX5eo2yvmDJb2JqyhP210F6m
 yNaH2UTWodDBxVpnRcCamSvySfc/JTr2kpDCVGyVDjdIER2W43euxXliKawtj9XxvAtt
 goK1UGHICHXm+uY8ldQ6mzq0Rkezgs6PMwHUvQrY2+6tatMRY6DxvIAbEwRgriiqQZ2S Yw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p3ftfbx9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 12:41:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB6Cf1Xd007647
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 12:41:01 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB6CewTE020412;
        Thu, 6 Dec 2018 12:40:59 GMT
Received: from unbuntlaptop (/197.157.0.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 04:40:58 -0800
Date:   Thu, 6 Dec 2018 15:40:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH] Revert "Staging: iio: adt7316: Add an extra check for
 'ret' equals to 0"
Message-ID: <20181206124047.GH3095@unbuntlaptop>
References: <20181205014900.4827-1-jeremyfertic@gmail.com>
 <fccdb26936a9cfcd5134c760cd918929ad3dfa19.camel@gmail.com>
 <20181205215953.GA2365@r2700x.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205215953.GA2365@r2700x.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:59:53PM -0700, Jeremy Fertic wrote:
> On Thu, Dec 06, 2018 at 01:25:55AM +0530, Shreeya Patel wrote:
> > On Tue, 2018-12-04 at 18:49 -0700, Jeremy Fertic wrote:
> > > This reverts commit 00426e99789357dbff7e719a092ce36a3ce49d94.
> > > 
> > > i2c_smbus_read_byte() returns 0 when a byte with the value 0 is read
> > > from
> > > the device. This is a valid read so revert the check for 0.
> > > 
> > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > > ---
> > 
> > Hi Jeremy,
> > 
> > As per my understanding, 0 value indicates no error but no data read.
> > Then how can this be a valid case?
> > 
> > Can you please make me understand that how can we consider this as a
> > valid case even when no data has been read?

It's not reading no data.  It's reading one byte of data and returning
it.

> > 
> > 
> > Thanks
> 
> I'm not sure I understand why the value 0 would indicate no data read.
> Doesn't that just mean a byte was read with the value 0.

Yes.  It does mean that.  Please don't ask rhetorical questions...  :(
This list is full of people who can't resist answering every question.

> For instance, if the input to the adc is 0V. Can you point me to where
> you're seeing that this would indicate no data read?

drivers/i2c/i2c-core-smbus.c
    88  /**
    89   * i2c_smbus_read_byte - SMBus "receive byte" protocol
    90   * @client: Handle to slave device
    91   *
    92   * This executes the SMBus "receive byte" protocol, returning negative errno
    93   * else the byte received from the device.
    94   */
    95  s32 i2c_smbus_read_byte(const struct i2c_client *client)
    96  {
    97          union i2c_smbus_data data;
    98          int status;
    99  
   100          status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
   101                                  I2C_SMBUS_READ, 0,
   102                                  I2C_SMBUS_BYTE, &data);
   103          return (status < 0) ? status : data.byte;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   104  }
   105  EXPORT_SYMBOL(i2c_smbus_read_byte);

You are right.  Commit 00426e997893 ("Staging: iio: adt7316: Add an
extra check for 'ret' equals to 0") needs to be reverted...

regards,
dan carpenter


