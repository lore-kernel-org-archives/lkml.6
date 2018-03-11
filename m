Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520747775; cv=none;
        d=google.com; s=arc-20160816;
        b=vsQcLktmBdYr7rEbRsB2bg7o5KKfvESzmzxGuqdcZHWXt+hONrVSjPHHwdd24FkF4M
         77AbVlNRT4U91bNaDMYLB+sDpO9M0ArgiVbGYsvrxwE7F0DjiK0bWr90x9/7A3RFg0K3
         vnBq5Rm4dWHTU647KELVSrdAT2qvXDoXjjOyY/xTzLGCtr3odTTynN/b0M+YRbqFVEn9
         HbaCiBJu9uQWkTCNqtqikrbjt53w98Crd4w0JSFH6glE3PaLLiGe5rz5V6Ar2qjutoQd
         naOtPBWnjHKwXWWjucRKJmVKkEnDonRbP2bukjrku6LEnYK4D9NwZavAe/QofwM/u+AW
         PBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ZsuQa/Qn2n9VlyEYHci6AkotNUdqttRpHs87YxzitKw=;
        b=izQbalq9jIYYRlRrxJQwXZG/+6hxmw4/n+Bv4USwFVT0L0MmxG0jdLharyKEMAN3mV
         W3unv8qGa7lVJN05nNYO5PBJXToN6POMqg4avxs10LOFusMzPU2g/aA67jViyBzBfDZO
         URm/Wd9/xWlZsiS91a5WGGCcIfqVPqU62D5a3hJ4Y4vz54f/+/8xaodUFNg6rKZt/hI8
         SOVwmmy7K1aRhCoDpqKq0w5AagCfEsI+oPfxwKYpbK7fwkeRJn3UwYSEjqagsJgA1IXB
         Ht6w8/ES14UrSuBg8tKcrnGXFJblI4BfBqoCzQgt8ASpPOvATfZKmfZ3hzN2PFqvuHlK
         79sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QqMfr8ci;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QqMfr8ci;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvswOAGLkPY0S8I7TsWvvqvirlti5IN7weuXHD+e4y0SZuNzPpgBcYa7CEtwJ61ycE8G6zRsQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] driver core: use put_device() instead of kfree()
Date: Sun, 11 Mar 2018 11:25:47 +0530
Message-Id: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594619619446744858?=
X-GMAIL-MSGID: =?utf-8?q?1594619619446744858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Arvind Yadav (4):
  [PATCH 1/4] base: soc: use put_device() instead of kfree()
  [PATCH 2/4] driver core: platform: use put_device() if device_register fail
  [PATCH 3/4] driver core: node: use put_device() if device_register fail
  [PATCH 4/4] driver core: cpu: use put_device() if device_register fail

 drivers/base/cpu.c      | 4 +++-
 drivers/base/node.c     | 4 +++-
 drivers/base/platform.c | 4 +++-
 drivers/base/soc.c      | 2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.7.4
