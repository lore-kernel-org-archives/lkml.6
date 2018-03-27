Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48AsEPl164KpeJlbBFg4++qtQ6gJjpDIqyS+fNgXM4QVtuKYj3P1bD7KK62GbhSrCwgis5o
ARC-Seal: i=1; a=rsa-sha256; t=1522168959; cv=none;
        d=google.com; s=arc-20160816;
        b=mdvXjWhw/14xhSKrs2SQ0pC2YmXMAR8vGMku8sIJYXHQkly9pXt643Shs6vghra+EQ
         qn8sEzGA1KrEdc99awS8D9iDXA5XDi1hPUC+/0ttrs8zLlcUtA2kQXCT8hGLU79ArIqb
         hrxwPdibrjFYnKC9e/twXk7k1isGvrPZ+EXSQ7SiJRk+xHCcxZ06GTbpoeN6MkNdNk2J
         EhDaASlctkXEpnqmMQXSOHEsz8vd4I46VWcL0lRYsBE5izLvvz7VapWeY7NXOhlRPi/C
         NCu4otqitjx6wZ8dR9AWXV8bxzbJzxu9P6V++Ntqf7102hN9tp1BtPQDLRJO4MOXdW0Z
         NHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ncau9VQK40pah4lFkj+NcP+srnWRLEtEEDTiPWAD/8g=;
        b=dGAEhxVbjKdK3Ojj79MkPWDD0puf5kQKA8l4g5QBLHmOsigxCnXdo8XAMm3Rl6CJad
         P4J14ghnQ9YdIN++fAwJ3U5dXapaZGhJDSDCBpbxzQgeZyIp2urc/6wcNgO87oDyIGEE
         77hkRrYvwbykpVEPhq4Qqewbdd2t42XVEyXxpgPpFlh0t7QlSw5X5BBKJi+U4kYzux9M
         ompKhjorj2L9sM6yxw3AQVfU5/jqWm9onmi+z3OP/2OkgtITHdIoxKlaEJdm2aANu1Pd
         /I46MADS/QL+BtJVoDYpo+ZbibFr2mvMm/mQv2/qyikHN8zisR7hL1cy9ds6lu0CH+BJ
         YXHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.15 092/105] hwmon: (k10temp) Add temperature offset for Ryzen 1900X
Date: Tue, 27 Mar 2018 18:28:12 +0200
Message-Id: <20180327162803.751729515@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109839284439815?=
X-GMAIL-MSGID: =?utf-8?q?1596109839284439815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 6509614fdd2d05c6926d50901a45d5dfb852b715 upstream.

Like the other CPUs from the same series, the 1900X has a
temperature offset of 27 degrees C.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/k10temp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -86,6 +86,7 @@ static const struct tctl_offset tctl_off
 	{ 0x17, "AMD Ryzen 7 1800X", 20000 },
 	{ 0x17, "AMD Ryzen Threadripper 1950X", 27000 },
 	{ 0x17, "AMD Ryzen Threadripper 1920X", 27000 },
+	{ 0x17, "AMD Ryzen Threadripper 1900X", 27000 },
 	{ 0x17, "AMD Ryzen Threadripper 1950", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1920", 10000 },
 	{ 0x17, "AMD Ryzen Threadripper 1910", 10000 },
