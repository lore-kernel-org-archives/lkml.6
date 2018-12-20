Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC0B20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OD9U3JRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbeLTJfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:35:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeLTJ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBK9Nu0M182771;
        Thu, 20 Dec 2018 09:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uN1NQBi9WSEEwDYklUj6bnXRHd3FK67kdSxD74WKSAM=;
 b=OD9U3JRrKZrjMQxaqHU3a5ux4Fom8LBvlrzy49ST7IvWrVEO/MsjbbpPxQG1EajP2oQX
 lTHbkMRa0XWwvFIBIUZkI7OqdaKwAka7voPME6jWQ1Le5lSxz7NMamOaad70bMhY4Mma
 donS4d9JgJlZRc3drwmJTWrXwuDb4tS+JSzL7AzZDm63cDJZGhi8aiVF2Y6BjLLa0357
 aNKm3qomdbq62vRoPhZVaK7mPtZPs188NtdWo8h3YCAVUmBeQN9cedjnpxmDDwZ7oUXD
 RqgkIy5G+IkNMxyPQ7AsiWWzk1uFhJdn5Bi6YjCo5kW8lqq6PEEPV0OfnVseiEgdwq3I Nw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pfh3a65em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 09:28:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBK9SCEc026909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Dec 2018 09:28:12 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBK9SCXE022153;
        Thu, 20 Dec 2018 09:28:12 GMT
Received: from kadam (/197.157.0.31)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 01:28:11 -0800
Date:   Thu, 20 Dec 2018 12:27:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Aymen Qader <qader.aymen@gmail.com>
Subject: Re: [PATCH] rts5208: add a missing check for the status of command
 sending
Message-ID: <20181220092745.GH15451@kadam>
References: <20181220075704.40732-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220075704.40732-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9112 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812200077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think maybe this is the first kernel patch I have recieved from you.

When you're adding error handling there are a couple ways to go wrong
and this is what I look at when I review error handling patches:
1) The error handling is not required.
2) The error handling is not complete.

I have messed up on both of these in my own patches because sometimes
the code is complicated to understand.  Sometimes there isn't any way
to recover from errors.  For example, we sometimes deliberately assume
that the PCI bus is working because if it's not the real fix is to buy
new hardware.

Another thing that helps is to try write about the real world impact
about the patch in the changelog.  Try ask, why has that bug not been
found before?  Always take a look at how the function is called and the
wider context.

regards,
dan carpenter

