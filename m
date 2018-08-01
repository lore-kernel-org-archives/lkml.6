Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D426C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7772083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v2F932TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7772083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387764AbeHAJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:52:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbeHAJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:52:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7183R3G021740;
        Wed, 1 Aug 2018 08:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=nWsqERvyl8MU8WoKk1PvGL+3vgq6kLafxCh1AdEqR3o=;
 b=v2F932TQhl9aozN0GNYwZuvKv7kC6diLDUB42CjPSiOOG47bFH1vjIDHt8cYaBl/Ux4G
 tPBJAK7G8i8m5Mb0R8UU5eN/HRlnXlCPxwOSpgsz+uYfkvnmR59knB8DLQqr6fyzqobq
 Vjb+cTNoPhXuZVTtxpVYz8brkumpjMtjXGV8IBubXRQdsOCZhHx9xW9DzvkSr/7iti88
 CC6ZzkcEljUZnGUl5s4hBXlbmce0ZC/Hw+CUJ9P25JGltKz4PXWlgUKy4uxMKjsyiT2a
 4dwhO8DwpU5hRp46rMNoDqACuEfSnkL55d7bI/ftKBRwoO2G9gJL0GihtdMoK5wgsvKX Yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwt4dfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 08:07:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7187XVh020283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 08:07:33 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7187Wav000456;
        Wed, 1 Aug 2018 08:07:32 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 01:07:31 -0700
Date:   Wed, 1 Aug 2018 11:07:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
Message-ID: <20180801080724.2vgzagooda56aypw@mwanda>
References: <20180801000039.44314-1-keescook@chromium.org>
 <20180801000039.44314-2-keescook@chromium.org>
 <20180801075744.qpppbaywp5dklxul@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801075744.qpppbaywp5dklxul@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8971 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 10:57:44AM +0300, Dan Carpenter wrote:
> The idea is nice, but I don't like the API.  The "_overflow" feels too
> specific because maybe we could check for other things in the future.
> Normally boolean macros should say they are boolean in the name and I
> would prefer if it returned zero on failure.
> 
> 	if (!checked_shift(dest, mask, shift)) {
> 	if (!shift_ok(dest, mask, shift)) {
> 	if (!safe_shift(dest, mask, shift)) {

Huh...  It turns out I put the argument order different as well.

If we wanted to keep it returning 1 on failure then some other names
are:

	if (shift_failed(dest, mask, shift)) {
	if (shift_error(dest, mask, shift)) {
	if (shift_overflow(dest, mask, shift)) {

regards,
dan carpenter

