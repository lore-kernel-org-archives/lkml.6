Return-Path: <michael@ozlabs.org>
X-Google-Smtp-Source: AH8x227ItcmzT2M/WFggtWnBNR0J2+/IeuT9PS81S3AAn7tQg42OvJVEayucitCWwjqg8eqQFArp
ARC-Seal: i=1; a=rsa-sha256; t=1518148838; cv=none;
        d=google.com; s=arc-20160816;
        b=X3Kot8dziR0Wkf7wN/DpE9E0GhfMY1D58gx4VBaLAS8pi5aMsSXBwpRnlQUGnKnP5h
         zFlp4jnwxKRXRuPPr94wW6UlMQWxnRci2iGV/2vjcDYrU4eBfpxXoXrBnI/EHMjoLBiN
         7txd5si6IgD0Ssq9pFEPNFOMM8gmCWfN+HgvaE+F34Xb+tAPKmm+ZAKRvxR8Yfg4AuhP
         I00AbzoqU/dcvC9DrpwIsJPiRbmgmebYwQHpIAERCjWvYwbxoWMisHKPIdVKOxHGt8cm
         1fKUojchXgLEFmIkhgGrOa0/+dJ1SWBgk/F8/XEQvPSSbP5SJ+flGdRwmzvO793nFCd+
         Kq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:subject:cc:from:to:in-reply-to
         :arc-authentication-results;
        bh=N1Vpr0wKfeyiD5PSRrA95fr3NrynWfQOkWIOCvcOo4w=;
        b=k48QhEGbIh6+wtgo4mRvfv6ojiTHQ1EfAgLfBQ+aMx2RUfjnD0i382fLweqp51a21V
         Rmw5cLay0QybHCvHo5UC0lZNo5SANBbFbjmL0zgTkMLNkstMpR4mXmpifkXX3MLT74S5
         4Ynv3PHFcQa6qn1bPd+e/jqwm9Q69MqlbTt2WOEaVT2XkT3Bak3SVV3hHUacdWTH1EDo
         bhq6cjHtK4N6Lusq47UKivwXAmYi3pqvl52VW8DWpuZoDJV3lJhDiuuKNkcPE1+Nlhvj
         GxLt+7o1ZHQyEU5NOMZg7v0gIvNLKzJc24ZVA82SPS3uokFoubtzvC1XZYIZtEXhqhKb
         W4Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=michael@ozlabs.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 2401:3900:2:1::2 as permitted sender) smtp.mailfrom=michael@ozlabs.org
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: dedab7f0d3137441a97fe7cf9b9ca5dbd20ca9a5
In-Reply-To: <20180130151144.32544-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>, Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ocxl: fix signed comparison with less than zero
Message-Id: <3zd1Ys6HkGz9sRm@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:33 +1100 (AEDT)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591030691319252976?=
X-GMAIL-MSGID: =?utf-8?q?1591894435941479188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-01-30 at 15:11:44 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the comparison of used < 0 is always false because
> uses is a size_t. Fix this by making used a ssize_t type.
> 
> Detected by Coccinelle:
> drivers/misc/ocxl/file.c:320:6-10: WARNING: Unsigned expression
> compared with zero: used < 0
> 
> Fixes: 5ef3166e8a32 ("ocxl: Driver code for 'generic' opencapi devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dedab7f0d3137441a97fe7cf9b9ca5

cheers
