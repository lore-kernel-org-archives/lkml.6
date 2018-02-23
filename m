Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225boCzjGoS2dDVl0WLXTUGzM3V2Ih/KEpzFncFBvxxQ2TS0moFaOMCf6v1nxFQLkHRiSNrW
ARC-Seal: i=1; a=rsa-sha256; t=1519411057; cv=none;
        d=google.com; s=arc-20160816;
        b=e48ZbbMERBjZQz/wWFoHC0bo1BEW0lLKByodXvmm959zV1C5FgHxPYb9XaEzNvJadk
         ILVfU5EgkrrXJijjiE0Zr4Xd7ihLgw3NlRgDKTaJYy+LHcsS/eUXPtvsVdu0opsJP9Na
         efsPKu7HvAdK5x9tgcS/OXPO7Ur/HROv3X0zfuqbRH18yNPGzHJwzhG8seReSmXxEWip
         w3L08IiVRsfHS9BFV8ASaVm4lEDvheOZPW0vKQvy1xdCU0S77TZDR/5KzWxTJAi8mFwB
         VXmZwyr2X41FHK3qymWcSwdSE5TWsVVR8GLNJZ3sUT4DZiqAWsqBzGqoqsr2iI9rHw0D
         XGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yPSmrOEQuMlbVHSkI4YgINBdbgd8gRvy4m4XV/PZrk8=;
        b=TmRSPbE8KlFjy1YjM1NC4BRVai0CqQDcX+HrnFNSavcc2mL3jiYjhGvQWSnkxVZ07n
         Fa/U5oTxion6iFMhE3Mvxw4jNeU400FhXaxEkmdJUTlH4F6Wt85w/+aJxXH+WyoRkER/
         4utPwp2M+lHm/i1KyyE6rVjyBf90uijo39s28Mi2uQF7eRJOjUW4d5uPrdrcjsts986a
         sT+1iopE04OSg/8MPu3ArwtkzSq9boEq5Ql1gqlCrl8W59XXBC0zuZ9qTMBlSTyfcDui
         Yqk1a/boUE04UBX931uy3oZsWbYfsAZ2/B376e0R6rQPX5/SXE7c54MimF0vIpIn/HVH
         OjvA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 105/193] amd-xgbe: Fix unused suspend handlers build warning
Date: Fri, 23 Feb 2018 19:25:38 +0100
Message-Id: <20180223170342.379743620@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217969147649025?=
X-GMAIL-MSGID: =?utf-8?q?1593217969147649025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 91eefaabf102c539e6f5531e9a1e5ed46d2b41ca upstream.

Fix:

  drivers/net/ethernet/amd/xgbe/xgbe-main.c:835:12: warning: ‘xgbe_suspend’ defined
    but not used [-Wunused-function]
  drivers/net/ethernet/amd/xgbe/xgbe-main.c:855:12: warning: ‘xgbe_resume’ defined
    but not used [-Wunused-function]

I see it during randconfig builds here.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -829,7 +829,7 @@ static int xgbe_remove(struct platform_d
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int xgbe_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
@@ -868,7 +868,7 @@ static int xgbe_resume(struct device *de
 
 	return ret;
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgbe_acpi_match[] = {
