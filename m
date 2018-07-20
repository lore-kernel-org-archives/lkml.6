Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BBEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBDD20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zdi8Ny66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBDD20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388011AbeGTR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:58:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46464 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTR6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:58:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6KH4ELl049419;
        Fri, 20 Jul 2018 17:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=DKK+vKjxUuhgOdbPj51faVVilUdoTCDEcgp3bK978t0=;
 b=zdi8Ny668WAKZgXnQ6nslMOIqdbzf0gJPO/JaGOEqeoRvIhZLmed7XuAezE+G0rx5/dt
 9GlA78TY9WUwFQT+nZp5sGJY5MDoEMo4aIA1PW7/4t6rlV2qS6MrMBtuLHyRCjrx0o1g
 Vy6ZnLrXKhryyUo8DWSqwfjODC6LZrv+aXgruKqbozN93FFAjOjlYeJW7uFhvxriJroV
 PKtfh4xQrrjj0TfKoWEvnx4Ft+/pJJJ99JwZb3z0kQLNjqL9pmh0KAvFNIUGRPJbjvGC
 zMy77RZYr4wf5hLWaL83hv/ouSipAiTvxngFYoyGv6iOUbWHHrHCQ1AeP7AuYvmq6150 xw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k9yjgv3bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 17:08:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6KH8cjF027440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 17:08:38 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6KH8b8d022708;
        Fri, 20 Jul 2018 17:08:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Jul 2018 10:08:37 -0700
Date:   Fri, 20 Jul 2018 10:08:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sphinx version dependencies?
Message-ID: <20180720170835.GH4800@magnolia>
References: <20180719181556.GA21435@thunk.org>
 <20180719190400.GB4800@magnolia>
 <44d73cd9926f58976a1269ff3cd3afb845ec84fa.camel@darmarit.de>
 <20180720150402.GA32320@infradead.org>
 <1cc801608a1e71b54fe97aae6f5ad2a0024e8e5d.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc801608a1e71b54fe97aae6f5ad2a0024e8e5d.camel@darmarit.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 06:28:09PM +0200, Markus Heiser wrote:
> Am Freitag, den 20.07.2018, 08:04 -0700 schrieb Christoph Hellwig:
> > On Fri, Jul 20, 2018 at 09:30:33AM +0200, Markus Heiser wrote:
> > > We have this discussion over and over again an I believe we will have it again
> > > and again, as long as we do not change our POV .. building viewing formats is
> > > an application not a part of the Kernel.
> > 
> > Sorry, but this is complete and utter bullshit.
> 
> Maybe .. I'am not a Kernel developer .. I only try to help with the doc tool-

It is (broken, that is, not bulls*).  Building the documentation as part
of the kernel build *is* an application.

The point of documentation is that we record knowledge and then anyone
ought to be able to read it, no matter what platform they choose, right?
So that means that for any given user, if their Linux distro packages
the doc build tools they ought to be able to build the fancy html stuff
and read it.  If they're more accustomed to virtualenv and pip, they
ought to be able to build the fancy html and read it too.

Anyway, this whole thread got started because Ted followed the
instructions, applied my Documentation/ patches, and the build broke.
From my POV this is just brokenness wrt to the rst spec in the docutils
egg/wheel/whatever python calls it now.

> chain. But if I don't want to install anything from the web, the plain text
> is not as bad.

It will be once we start uploading filesystem format documentation
that's full of juicy tables and diagrams...

> > 
> > If that was the case we could skip all that RST stuff and just stick
> > to text files.  If we want fancy docs it better behave like the rest
> > of the kernel and just works.  python virtual environments are just
> > not going to cut it as they lead to a long-term maintainance nightmare.
> 
> Really a nightmare? This is what I do on my ubuntu/debian box ... I do
> prefer py3 so I installed *virtualenv-py3* once from distro's package
> manager:
> 
> $ sudo apt install python3-virtualenv
> 
> To setup up a environment for building htmldocs:
> 
> $ python3 -m virtualenv py3env
> $ ./py3env/bin/pip install -r ./Documentation/sphinx/requirements.txt

This isn't going to fly in $corporate hermetically sealed kernel build
environment.  It's ok to add things to the list of packages pulled in by
the provisioning system prior to a kernel build, but we cannot support
downloading python wheels for kernel builds.  Therefore the distro
packages have to work.

Which is fine, because the problem here is that whatever pip installs is
less forgiving than the distro packaged versions. :)

--D

> 
> now I have all installed in the in the py3env folder. To build htmldocs
> with:
> 
>  $ SPHINXBUILD=./py3env/bin/sphinx-build make htmldocs
> 
> If the env is no longer needed:
> 
>  $ rm -r py3env
> 
>  -- Markus --
> 
> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-doc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
