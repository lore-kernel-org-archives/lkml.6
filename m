Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/i3ziGPRakDBnxGpqIn+3BhaS4Elk1obtmXw7AUMTEJYLrEjAyT/dRbZkdR/QWb3bOWQ9U
ARC-Seal: i=1; a=rsa-sha256; t=1522346684; cv=none;
        d=google.com; s=arc-20160816;
        b=hC63p6Mes1I7kfY7lzaFRFm1+/+aTx9kS2Mdv6bgIYiiz/7H9V7N4UMY8ke6H2Cp5A
         zGyClKPeAjVTY4AXGhT+mSmzrQpVWPIL2tV+zaKiABq7UHUB1yvgIdVzEPuZe2SXhr+m
         2GW8FDboTmpF6KL7h6ufRwXLKy39O/9KbpugWcgriaIZlOi9zS9FIIfqkz8o0U2/Q3jY
         16DYQvxnhsN2mdvwhlBOGC+JcV6wc9uif2cquI8ITII7shNbSINvHoe4Yg623YZXML3u
         27HSt5FxlkSWMFIiZmDOTh7tcH+BHpcV7jjj0QqkJg7onlMxESu+vFh7aWyW14hEgaCZ
         9XEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FJXsdidsBeTaZEYtLkwFD6tMg1z7HTSciyaHZf9TZyg=;
        b=iJvB351rsi8xdHN79W0Ehbd2v/AbdSrms18iwxcZ8RXkGMmiaGrD0Rxk84yT0WDWTP
         eluvAutiYrfrjfOt6X7YoB4Azz6nPFAutMG8XgpqP6gfwnaUX62J6jroq6Qn0ZPaAZCJ
         AuoLYni7m4p2SV7NjUTTsnZxXyYwfYKrJr9UCcuJNa2RD8zCaFFcAT0+GW/w/Mn4w6tV
         iM29ePf+Ndw9J14n+XbKQfO7EfIEGiYu5PCrGwm6BfRy0gES2ufHrrI0x6m9h/aX3pT1
         R+CHhniPFqk3MmIHOAUThzqGU6MEFAh5PaR+wAMlTCrzLM4q5YanTH2wpe7WqHSw2nkh
         9UbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 04/43] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Thu, 29 Mar 2018 19:59:59 +0200
Message-Id: <20180329175730.531947625@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296141904379331?=
X-GMAIL-MSGID: =?utf-8?q?1596296196936341632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>


[ Upstream commit 2399ac42e762ab25c58420e25359b2921afdc55f ]

The sysfs_create_link_nowarn() is going to be used in phylib framework in
subsequent patch which can be built as module. Hence, export
sysfs_create_link_nowarn() to avoid build errors.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysfs/symlink.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -107,6 +107,7 @@ int sysfs_create_link_nowarn(struct kobj
 {
 	return sysfs_do_create_link(kobj, target, name, 0);
 }
+EXPORT_SYMBOL_GPL(sysfs_create_link_nowarn);
 
 /**
  *	sysfs_delete_link - remove symlink in object's directory.
