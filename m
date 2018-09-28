Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E30C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD69E215EB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXYQuFRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD69E215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeI1OgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:36:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54778 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeI1OgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:36:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8S8DPlm023979;
        Fri, 28 Sep 2018 08:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MiDYgWceKmaxYr5lv2EbMuq6e2rIf9fNA839ZV8hvtY=;
 b=jXYQuFRcvyOqbpVpyqTWjgh4P72wfN6LlXH6QqEuXv/Bsh9ORL3c25o3P/N6lvH3Vkyb
 tZSgvC/2XRl43H53AC/XIgXF0F7ZWieTz/yV+Yalyzs0VpG3WZFOwFWuGBFG1ZtlJ3sQ
 Baoc1K+B+d/pdt4HBOr0bcGpfzl7WjJeOGkeU+eObVX3a125LyBIzh/vylmqY+wFJ/77
 mtUd42OqKCOetGHTypL39A9UlFa962IbITaNQN8OMlnU7JBQvm/pf8dMJlAiorAtxOQg
 Uf2sufzSREytDAoffs3ATm+cS463seMup66Gnqeejz/XORAIux2PER3eegeWl5r03Qdd EQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mnd5txhb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:13:33 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8S8DXmb009874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Sep 2018 08:13:33 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8S8DWaq002522;
        Fri, 28 Sep 2018 08:13:32 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Sep 2018 01:13:32 -0700
Date:   Fri, 28 Sep 2018 11:13:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aymen Qader <qader.aymen@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] staging: ks7010: Add null pointer check for skb
Message-ID: <20180928081325.krgawue3cs6mavw2@mwanda>
References: <20180927151614.25470-1-qader.aymen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927151614.25470-1-qader.aymen@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=495
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to try running Smatch on your patches.  This is the
second one where maybe the results would have been interesting.

git clone http://repo.or.cz/w/smatch.git
cd smatch
make
cd ~/kernel/src/
~/smatch/smatch_scripts/kchecker drivers/staging/ks7010/ks_hostif.c

This patch introduced a problem, but the earlier one fixed a potential
problem in rtl8723bs:

drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1274 OnAssocReq() error: uninitialized symbol 'ie_len'.

Unfortunately, Smatch missed the potential NULL dereference in
OnAssocReq()...  It wouldn't be that hard to fix...

regards,
dan carpenter
