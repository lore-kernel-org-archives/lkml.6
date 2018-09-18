Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBBBECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30D214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="w/oTTN9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F30D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeIRUNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:13:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbeIRUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:13:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8IEcpff102683;
        Tue, 18 Sep 2018 14:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3QI1fwm0IUam2fWty8yFtGtrWNDG/B4KeLJyYHHZilA=;
 b=w/oTTN9J5rKIulsguqryxuLMhTthYi2UMPUxNpRbbHQngCdN8+QCAzSqmdfAWiXxL5hC
 5B9MR5jOFGh8QjmGMkBHyAGx+PqHNolR6n0apFhzGJi6wgSn0J1OYU2OXmlg0oC6fue5
 hTCY/f5UZTJK6M9rngYemjqvSqTohDRiMlEG4qAIgdgcEeDDstgqVSDOQyaAKNZfVIlp
 Rxf6RuPerQBmud9mn//ffmFKH9I+O7cdCQN610mzMhYuY6Eyoi1oJcMuC9C1m7Q6sCzM
 d97ztqcE84csyury7DSjVBt/ONS4T45zA0ZwnlmlrLqePU/73qNBykkoLjz/Z5jfzY9H gw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mgtqqvw93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:39:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8IEdZUc012466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 14:39:35 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8IEdXDk006880;
        Tue, 18 Sep 2018 14:39:33 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Sep 2018 07:39:33 -0700
Date:   Tue, 18 Sep 2018 07:39:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] docs: fix some broken documentation references
Message-ID: <20180918143931.GA4590@magnolia>
References: <6b47bf56b898c48a0dc3cd42283c9e5c7c23367a.1537210894.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b47bf56b898c48a0dc3cd42283c9e5c7c23367a.1537210894.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 03:02:34PM -0400, Mauro Carvalho Chehab wrote:
> Some documentation files received recent changes and are
> pointing to wrong places.
> 
> Those references can easily fixed with the help of a
> script:
> 
> 	$ ./scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks for fixing up the ext4 parts!

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  Documentation/filesystems/dax.txt  | 2 +-
>  Documentation/filesystems/ext2.txt | 2 +-
>  MAINTAINERS                        | 4 ++--
>  net/bridge/Kconfig                 | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 70cb68bed2e8..bc393e0a22b8 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -75,7 +75,7 @@ exposure of uninitialized data through mmap.
>  
>  These filesystems may be used for inspiration:
>  - ext2: see Documentation/filesystems/ext2.txt
> -- ext4: see Documentation/filesystems/ext4.txt
> +- ext4: see Documentation/filesystems/ext4/ext4.rst
>  - xfs:  see Documentation/filesystems/xfs.txt
>  
>  
> diff --git a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
> index 81c0becab225..a45c9fc0747b 100644
> --- a/Documentation/filesystems/ext2.txt
> +++ b/Documentation/filesystems/ext2.txt
> @@ -358,7 +358,7 @@ and are copied into the filesystem.  If a transaction is incomplete at
>  the time of the crash, then there is no guarantee of consistency for
>  the blocks in that transaction so they are discarded (which means any
>  filesystem changes they represent are also lost).
> -Check Documentation/filesystems/ext4.txt if you want to read more about
> +Check Documentation/filesystems/ext4/ext4.rst if you want to read more about
>  ext4 and journaling.
>  
>  References
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9989925f658d..078a4cf6d064 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -840,7 +840,7 @@ ANALOG DEVICES INC ADGS1408 DRIVER
>  M:	Mircea Caprioru <mircea.caprioru@analog.com>
>  S:	Supported
>  F:	drivers/mux/adgs1408.c
> -F:	Documentation/devicetree/bindings/mux/adgs1408.txt
> +F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
>  
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
> @@ -5515,7 +5515,7 @@ W:	http://ext4.wiki.kernel.org
>  Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
>  S:	Maintained
> -F:	Documentation/filesystems/ext4.txt
> +F:	Documentation/filesystems/ext4/ext4.rst
>  F:	fs/ext4/
>  
>  Extended Verification Module (EVM)
> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
> index aa0d3b2f1bb7..3625d6ade45c 100644
> --- a/net/bridge/Kconfig
> +++ b/net/bridge/Kconfig
> @@ -17,7 +17,7 @@ config BRIDGE
>  	  other third party bridge products.
>  
>  	  In order to use the Ethernet bridge, you'll need the bridge
> -	  configuration tools; see <file:Documentation/networking/bridge.txt>
> +	  configuration tools; see <file:Documentation/networking/bridge.rst>
>  	  for location. Please read the Bridge mini-HOWTO for more
>  	  information.
>  
> -- 
> 2.17.1
> 
