Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpC71Iiy7D13AwD7ZrDxdbJhkqxNKzxKQxs+/sTGydmg6ZJhmNLPJS6JZHNpqfAUSYTSmNv
ARC-Seal: i=1; a=rsa-sha256; t=1525116421; cv=none;
        d=google.com; s=arc-20160816;
        b=rM5dJUTAGq94s3fv8Xsh5jHNG+3MCtMF0FLKEnb65gVzcMc4UzUbJ2Hp1SUnfwVwk1
         YqLCAO5WAhUEuvFBR7DvlwNsyY6vmTVu3UReKbzR4WYH/3nUVg3MMKzBD+EFEPizyxD+
         B2mCi6LzSAqa8aEEHKR1XAGBdyvLq9OKmFHijcl+JxSJEy77r2kbt43KImR9V/ys0PfK
         9dXhlMXzGhrrflEBWU97zx8MgxOKYFL2CoPT9j8rKEw9K7hM6Y8OLuxanYKGgRAcOYBz
         tu+T3C0eN2h9mMfurzdlSoDMb/B3DqSxI1Ol6lj/6JWpI8tGb1dwOiiWhm+M690WgOOQ
         T9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=kYBTDKSDlfnwOBfvdb3S9ZhpIIO9UmVC/TnZ/Y371Cg=;
        b=GsR9wknUJpLKj73gYp3GGPoDLJITsxLrxuChyFUWfcSCvPcx96nLUKyRiJV5v/rha9
         CgOf11ZE9zZjBXB9ky7c1KT8JSJzPcUeDlo5aKDfg342WRkoJ4ayaVT125WqGL4CikYK
         39ngE/kt2jiLKVYTrwyFh2Dpf4gwlpSENFqf7WQ4iXve8170idIwR6P3OrUmO1NA84Ka
         sEetU8IHi3wfFih9ZxOkJY7NU/kbUelN6gnZAZbqTF/roy8ewcOI/6uojpeuQ4le+eYn
         ui8QJqombWzbbRc+TkMirjSSnVYQxhqk0y8XjvOUZKP+LEYRbR9n1OoFK1ZA1tyW0MMz
         IueQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60D422DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamil Lulko <kamilx.lulko@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 4.14 19/91] usb: core: Add quirk for HP v222w 16GB Mini
Date: Mon, 30 Apr 2018 12:24:01 -0700
Message-Id: <20180430184005.218334146@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291962669964?=
X-GMAIL-MSGID: =?utf-8?q?1599200476619136732?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamil Lulko <kamilx.lulko@intel.com>

commit 3180dabe08e3653bf0a838553905d88f3773f29c upstream.

Add DELAY_INIT quirk to fix the following problem with HP
v222w 16GB Mini:

usb 1-3: unable to read config index 0 descriptor/start: -110
usb 1-3: can't read configurations, error -110
usb 1-3: can't set config #1, error -110

Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -45,6 +45,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },
 
+	/* HP v222w 16GB Mini USB Drive */
+	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 
