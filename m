Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476185-2-10530558337940191787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476184; b=YswVhZdsP5Y4TxYpCnY4BYtEh1OVhz/NOGHqlnHXRp8thAt
    5sX4xIbNoL+xod8ktK4wrSNKYPksNmyOcLgXP14DNHvEg9hJDTv9M8UrOTkSwmnE
    JC+J1mayets1OzLrHDbXv8kI64yPcj9yhGYw5KZZMZvJ1V/9WS4tuGedgbpv33Ks
    S82VfH0LfjdBljftV2Gb0grkx4q/RXkpeiRGSgotvW+P54/qA9i4+PDPYWPtemGZ
    3ZoBzZ3df+RnS1cJLusNe3MFhxhFZ0yr+4RPJvEykhQzZQsTTyG1FLgHEQYI4nN5
    dt2AXrsqLEJYxQTrJYuZc1x7Y9lR2gMVCIeRw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521476184; bh=N
    qoXpU5W0rUSoN2bdadPjQpTNk0DrJH8P3xiN7s72FE=; b=QjhmQcxxOFqBxSfsT
    DAOftLogchjnNWFsSbIGqGd5S6Wy7FUQm8nVsYUXNRf2N9MBhzqdxLHwoBM76yzR
    72VsBKZbbrC5iCNTYL6t9afIV/atKvKYRmaDEEJCVgIlsKtIAfy2Dvl0L0uxV3bA
    CMBfbYssmM2SoNZ0QHY1q5/LkVTss+wWPVrXIz4Xu7crVr0epaHXNW3EwrixHDL7
    g4nD08hYizNBsdKu4kzxI13Q3oCBUKVzWQwZ+l8OempfVo4snhxBmPpoMhmgRI3k
    u2cXWQ0jc/BhKd1YqbXRVWTKsUdu+isuK1XkHwvzdboAjogB0u3ApboyKUr5/Mjh
    WE/IQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpfihhrghmtghlohhuugdrtghomhdplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeefpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeegledvjecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpfihhrghmtghlohhuugdrtghomhdplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeefpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeegledvjecuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 17:16:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Oucharek <dougso@me.com>
Subject: Re: [PATCH] staging: lustre: o2iblnd: Enable Multiple OPA Endpoints
 between Nodes
Message-ID: <20180319161618.GA26103@kroah.com>
References: <2253BE75-D4ED-4021-BBA1-BCBF2C6770CB@me.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2253BE75-D4ED-4021-BBA1-BCBF2C6770CB@me.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, "Dilger, Andreas" <andreas.dilger@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:53:46PM -0700, Doug Oucharek wrote:
> OPA driver optimizations are based on the MPI model where it is
> expected to have multiple endpoints between two given nodes. To
> enable this optimization for Lustre, we need to make it possible,
> via an LND-specific tuneable, to create multiple endpoints and to
> balance the traffic over them.
> 
> Both sides of a connection must have this patch for it to work.
> Only the active side of the connection (usually the client)
> needs to have the new tuneable set > 1.
> 
> Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8943
> Reviewed-on: https://review.whamcloud.com/25168
> Reviewed-by: Amir Shehata <amir.shehata@intel.com>
> Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: Doug Oucharek <dougso@me.com>
> ---
> .../lustre/include/uapi/linux/lnet/lnet-dlc.h      |  3 ++-
> .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    | 17 ++++++++++++---
> .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 25 +++++++++++++++-------
> .../lustre/lnet/klnds/o2iblnd/o2iblnd_modparams.c  |  9 ++++++++
> 4 files changed, 42 insertions(+), 12 deletions(-)

Does not apply to my tree at all :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
