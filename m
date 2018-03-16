Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AG47ELvI+oArrdX69q1e32Z+hdoFIyuW3dXQkwxgRAPpCnXpw7JPQkGagYv3bVm18heHRhI4EjvT
ARC-Seal: i=1; a=rsa-sha256; t=1521230049; cv=none;
        d=google.com; s=arc-20160816;
        b=omdglTNQMBrVNit1evUmIDakTlxOZcgdRrVdKNUfcGi+mVWy36nsQeDA6szjNM7bI2
         0rzVWl0hOWqMwtSoiwpGOsW0T7ybOp4aa5IxhPdy096bUvGfYiMyiQhOT2zOIX98lqlR
         iTWcU/Ky4qSJ2fSHtJMnzO7yVGOCAxhyGXuHqipkOD3p3+4SCBDOR5PxGcavxmdb/XLr
         Md6XWfXFIoT3zvlDtpa4Axj//9zG3f9PIjXfnLo3+hD6QG1OJh6v66QB4D5G73TpKZtN
         8u9laPZGpxCKxBxjDK+vAhHAM7/YeG26anVg3plzb1SViDfODiUPd+iwT5H+1KVA+W19
         HDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RKDniI2sYu5TSgkKjvmPFENgrhpDHUeDLh0HnEJY5ck=;
        b=xH5vPQQxcu1ltvOQcsMwKtHDamx2YIDxP0hxf2YGvZawCm+WPxyvnb+2iTO3Y89GQu
         pYNEJKEPBogBbYAbajIfWs3pYpLyDyZ6AObhPA2iB+QnDy9mV/W5oI3BfTV67duH811t
         albWikyJt/yCNbIi5rn5p+rELV6tfvb/8Bro0Tw6h0o7obU+Ua9JFAST9WFVNiW0oKru
         jWWfP0T2V6rCDGHZM/AyXl9+W/B6TayxIQpqnIfcRo4ix6MLVgsMQ9cxarhKu/TD5uXd
         W2QrRYXt1plv8gYNhlIVW0pyTjPvi58TPXSECNvisxaHyJt1PFeJ0pblkWgNaBCZQ3CZ
         Yfgw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=4eyQz1wK;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=4eyQz1wK;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Fri, 16 Mar 2018 20:54:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Message-ID: <20180316195403.GA8735@lunn.ch>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1595125321034042256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> The phydrv->mdiodrv.flags can be accessible only after call to of_phy_connect()/phy_connect(), 

You need to use a function like of_phy_find_device() to get the
phydev, set the flag, and then call phy_connect_direct(). 

	Andrew
