Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476201-2-10702523817543824346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521476200; b=uCuk8125hHEX5hBv6wGRY/ydnsZPpXN2Inh1jfM6Tj6Jv3b
    8vrgq64J7/crMYZ2zlY2WpIj0OrlgDBGrKTz/ZqREmtzC1me29JvgfqsyZwDqW3D
    ib6QeKvE0NqTJJBgINAHsrPHJUrPYL/L1DBcV3CfY9m2f5TVCAw+bDmolO2Uq9Yh
    FHqPZGfy8pk9TD1BRIxYl7+9/kFUL5MVE7xGNca4iFCQJcfqawoin9YUEAL3rMCa
    PW/ug9cj6u/I7O6+omSsPwgGH4t8si5lghBbATVVhw8QtKesP7AcWRA+4XHhSd5g
    /bc9lsx1GMIzlm+KrosI+GgN6frafTBHueccU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521476200; bh=3
    NpiYYS5fre4YhsWKkvtF8uNCgTpz4WCWuyQtgtZvSg=; b=CVoa4Do94IFQBOFgo
    MEUIKujbOPwhN73+M2rz8lMsSjgUQXkhc/oQG+WJgP4ag3qN/j+n7AOJltZ+UgZ2
    S0VT35KsbeIcjqr4ifFNHc2Gy0wm/dpO3z7G0LGDqufigOWHDNGrd4iX4OwVjiG0
    AHDmnsp2v07jkO5itJemj7ggcmH8PGWe+l0f9TYX9phUq5K24ogF9hrlvKiPZ2ay
    j066/wL+mi/KIiMULi2tQgySeIVLAEM+zOMzNT7KbFDXlToQbetWeSOyVd9Ts9Ze
    cJ5lTh4w7kuwt4a6cd3otdyezMoSWbq2mUU29lS7iFq+FITy5ESPnNRoAeis3NL2
    AVnkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpfihhrghmtghlohhuugdrtghomhdplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepgeeiieefuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepihhnthgvlhdrtghomhdpfihhrghmtghlohhuugdrtghomhdplhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgnecukfhppedugedtrddvuddurdduieeirddufeejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudefjedphhgvlhhopehfrhgrgihinhhushdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepgeeiieefuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 17:16:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Doug Oucharek <dougso@me.com>
Subject: Re: [PATCH] staging: lustre: o2iblnd: Fix FastReg map/unmap for MLX5
Message-ID: <20180319161632.GB26103@kroah.com>
References: <B5E4E902-16A7-4279-BE5A-8117E23286E9@me.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B5E4E902-16A7-4279-BE5A-8117E23286E9@me.com>
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

On Wed, Mar 14, 2018 at 11:18:30PM -0700, Doug Oucharek wrote:
> The FastReg support in ko2iblnd was not unmapping pool items
> causing the items to leak.  In addition, the mapping code
> is not growing the pool like we do with FMR.
> 
> This patch makes sure we are unmapping FastReg pool elements
> when we are done with them.  It also makes sure the pool
> will grow when we depleat the pool.
> 
> Signed-off-by: Doug Oucharek <doug.s.oucharek@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9472
> Reviewed-on: https://review.whamcloud.com/27015
> Reviewed-by: Andrew Perepechko <andrew.perepechko@seagate.com>
> Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
> Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: Doug Oucharek <dougso@me.com>
> ---
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |  2 +-
> drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 12 ++++--------
> 2 files changed, 5 insertions(+), 9 deletions(-)

Also does not apply :(

Please rebase and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
