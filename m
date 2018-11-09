Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55696C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173FD20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgtqyWd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173FD20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeKJC5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:57:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:57:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA9HE7mk093378;
        Fri, 9 Nov 2018 17:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=PzSxDdCAAfn0UELXMkkGvuB4gDF44u68SXTYg5cOx7U=;
 b=NgtqyWd3+tQ3fvPNzYo+00gM5UfHsTS5cUOxKryxYGWlHLMRoQlzbZPRcl7CcIl0d9S6
 S9klrRjdMKTbz7nPZJ9JB4b6PARsnSAgGy/Ry31qZvGzFloVdxqUR9F5Vghadd3khosW
 rs6IrAwk1B2qFsezfQ+465oXC5pA/4NoGYklnJp9xQqEpghsMkmuJdWXbayR7pTWzcIQ
 yw6yQUTzWer+64skWSTaZo7+dCKNz1AUCrc6/YoetQDW0DYrhjiRcGMS+mRxyIg0d1Bx
 vNdt0bS4LtQfXC1CqqexVT04m2H/r20XnNIky3Tbc2djmzIYRMSN8XT0dzAuiSl5/bc1 zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nh4ar86kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Nov 2018 17:16:08 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA9HG7FE030304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Nov 2018 17:16:07 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA9HG6eV032308;
        Fri, 9 Nov 2018 17:16:06 GMT
Received: from unbuntlaptop (/148.87.23.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 09:16:06 -0800
Date:   Fri, 9 Nov 2018 20:15:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerry Lin <wahahab11@gmail.com>
Cc:     Greg Kroah-Hartman <greg@kroah.com>, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>, ghartman@google.com,
        astrachan@google.com, linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
Message-ID: <20181109171558.GA8323@unbuntlaptop>
References: <20181107023043.GA18052@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107023043.GA18052@ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811090157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
> Add a attribute called permissions under vsoc device node for examining
> current granted permissions in vsoc_device.
> 
> This file will display permissions in following format:
>   begin_offset  end_offset  owner_offset  owned_value
>             %x          %x            %x           %x
> 

(I'm not totally an expert on sysfs rules).

Sysfs are supposed to be one value per file, so instead of doing this
you would create a directory with four files like
vsoc_device/begin_offset vsoc_device/end_offset etc.  And each would
just hae a %x output.

> +static ssize_t permissions_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buffer)
> +{
> +	struct fd_scoped_permission_node *node;
> +	char *row;
> +	int ret;
> +	ssize_t written = 0;
> +
> +	row = kzalloc(sizeof(char) * 128, GFP_KERNEL);
> +	if (!row)
> +		return 0;

Don't allocate this, just snprintf() directly into the buffer.

regards,
dan carpenter

