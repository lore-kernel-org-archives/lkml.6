Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv7tPO2qpA6cKLAcBYqbMme9untUb43TWYlE94AeC4+PPEWW9CrrnlFEDMuM0JUbfMOajui
ARC-Seal: i=1; a=rsa-sha256; t=1521214389; cv=none;
        d=google.com; s=arc-20160816;
        b=d7lpKnOl7JHGcdyQh43NXkBrv3ZD5j+XnvEfmfINP0wAPD9KxH4sobVLcJ9D+hkkio
         US2DtQmn6lDGjdtu0G0M313owdD2w0yTQS14trYXG/02Uy3Qy+jm7k3Zng4+BOtLPnF4
         39EJxkGeOp4pXeprmyiNiXmZ/6E9zW7hpbt45l4xzDchDyoYAFlaXOHfW0UDdSjJlv+T
         SYT515yP8x2UIyCwRWfnDEbCMFxeSiDsRs9Tn6WmDMYwFF6jBRwPpJGNlM49GNnO1ZIX
         LfAODSQt9/mWpFC7XI3I+VE/n+h1Fh/N2gWWs6oAJrwkHSuemUT41oll+scKITm+2dse
         4MmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ick8qStxivkJAYCW2JXxJ1hG0bj5vEuJ57UZ8O+pr80=;
        b=yT4gUTRqNbwrWdzyGalK++x+jjd2l6ns3BvmNCI9unNWKN5Ym7XM/FdcoOEo98m9xL
         bStNhCARulGGvVNcuJpYAurpH/TlFSiMxscV2ocZP7LYIPWzQ5198jj89rk6zbuv1TSl
         SGzLMEbavtNjcP/g1VQxKmZYRoh7y01jjDUfi3WMWRD0V9KiaxBbXy+zETeVE7OL0Lim
         Q/UDjzFyOvLuM8h3cghHo3pT30P1S7G+BVPx/BGHOCNNscKmOOs3BHpuPF5TrRA2YJyt
         2pBLxL4OY/wWTg12KM8ZfLG4BKh5pPERYCyM5/TyhSmriywwBjVh3qukyzoNAfTOJYDZ
         BT/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	stable@kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.9 75/86] uas: fix comparison for error code
Date: Fri, 16 Mar 2018 16:23:38 +0100
Message-Id: <20180316152322.402914504@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108310839479923?=
X-GMAIL-MSGID: =?utf-8?q?1595108899361521853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 9a513c905bb95bef79d96feb08621c1ec8d8c4bb upstream.

A typo broke the comparison.

Fixes: cbeef22fd611 ("usb: uas: unconditionally bring back host after reset")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
CC: stable@kernel.org
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1076,7 +1076,7 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err && err != ENODEV)
+	if (err && err != -ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
