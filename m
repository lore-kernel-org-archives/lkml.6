Return-Path: <changbin.du@intel.com>
X-Google-Smtp-Source: AIpwx48AG5bba/sY5+Hyi7bMxEQ4Go4xiYUUKhYgj4M5PiaSEppN55MKovAB+/msKjsmxyS/YJld
ARC-Seal: i=1; a=rsa-sha256; t=1523156213; cv=none;
        d=google.com; s=arc-20160816;
        b=ccJxVh1lBX/Uy4Z9j8CHBOeB34mqA+zP5LfKg2eio/U1CQK4e8I5qiGsxbp7IOGjpy
         L0L1kFl5V1AsUhlYWaV0DSyujmL/0PZQ1ZRr+HK7TV1zmhoN5o9M28aJXHVwmSWR5s+w
         HKfbqUlQn5zpQUepV9FqgTqziighniDLSq81frq4jeWOJlO1BFcZpeNwDb83aICQAQRO
         gJn85w1UTgIOP+Ato68H30uPVChyws4ZLJJTg03wPgI40ivyueIytujp3SdcUjtwTDxj
         fZW8fu9y9kLb5FOwHysoi9nlNIwiwNasxrIJv5VD9WJ6nWWDzoJhEr2g8EFw1LW2SNxg
         mhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=BA/EqKK4uhZMTCNh6WlcqXsqJfa1ZvO8wii2Kdfi29k=;
        b=Aht7mIG/d126rDfhLuVpbbP1eOjc5KiMtIZY/DsLG++hjNqRfBEv475GPHfEZu7k52
         oA1G4G3Nk15mOr0NQrZAG51ppos65i1FciSXvEO8th3jqEaaA0wHrLjzGDjcdm6mpPJr
         1pMPpAniEW9AIqcT4EzOZR7kYbu7K+RF0TfTbYrGbZzrYJVFTQvK9OgDE4Pl/uhsDXEK
         EkfdMzlI80r5lzVFKhzq6XNZGN9Ac0HgRQwy7DttAFTHAWwJbJ98ODJ0ZOcSj9ux2Dpf
         mjPHvOt9ZJnTt4PRmNxHx65Ol1NSXsP+eoMArQ26aTvs+QGmYqky7Fzh6qUOirYHNiEE
         RFhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of changbin.du@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=changbin.du@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of changbin.du@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=changbin.du@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,421,1517904000";
   d="scan'208";a="30963110"
From: changbin.du@intel.com
To: corbet@lwn.net
Cc: gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changbin Du <changbin.du@intel.com>
Subject: [PATCH] Documentation: fix reST markup error in driver-api/usb/typec.rst
Date: Sun,  8 Apr 2018 10:47:12 +0800
Message-Id: <1523155632-10301-1-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597145050022316515?=
X-GMAIL-MSGID: =?utf-8?q?1597145050022316515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

There is an format error in driver-api/usb/typec.rst that breaks sphinx
docs building.

reST markup error:
/home/changbin/work/linux/Documentation/driver-api/usb/typec.rst:215: (SEVERE/4) Unexpected section title or transition.

------------------------
Documentation/Makefile:68: recipe for target 'htmldocs' failed
make[1]: *** [htmldocs] Error 1
Makefile:1527: recipe for target 'htmldocs' failed
make: *** [htmldocs] Error 2

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 Documentation/driver-api/usb/typec.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb3194..48ff580 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -210,7 +210,7 @@ If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
 port drivers can use USB Role Class API with those.
 
-Illustration of the muxes behind a connector that supports an alternate mode:
+Illustration of the muxes behind a connector that supports an alternate mode::
 
                      ------------------------
                      |       Connector      |
-- 
2.7.4
