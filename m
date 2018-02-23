Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAaSj4zlKuiiq1FB1/fvM9Qo5SDhLdpwrsVhWGOoeoxvb80zxxlWV0GQWOoKHyuq4mzhdS
ARC-Seal: i=1; a=rsa-sha256; t=1519410820; cv=none;
        d=google.com; s=arc-20160816;
        b=YYUaDF2+9vWthfDskfbc1do649RErOmZhK1EBOu1gcG0XsV31Einhpz9KEb/awXh6c
         2upVeU8b3gC8ufyeqNzB39j2g2Z1Fq7IqPotAc8KXYm1QvbX36qwu9CGveWJVKIetd2T
         tG/sw+zZIa8F8Ulkt9NchJcILBbuuROxM+3LbVhJIK2VNe6qoW42Wc0AwXuNxSYIN5co
         IskYV1mDjykEH6w//rypLVlRZLa/zkQgq/1Jb8WiiL0Y+8zgj9+oYA3Zk5gt0f+fjVQF
         Kj6adWxae5XRrqucZJo9TV/J8MfSMJdQYslhIHQjx1uPQPypm1+JWQzfaEXc09mheLvM
         Okdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jdLeZVcmmBDlxoaAnKDB5JROL4mHfppyrOoJPZRkWPc=;
        b=thEv5OS7mdzhMFWZkqsfRLqgyR9ycXNzDvVcchU5DxlThEXgbMQIUgAJLet3j/aEQh
         2Bxhz5WhgB2ETb2E8ba+lLzLy8xvsy68Ueicod5cAv2wJxvQHKy+BzaopSSwNezRf12g
         c+BvA7Sjnc42Yudr8vDG6LJ2uibLRr6SC/OtpOPIyfvKCT600c2kNcdNSOHPMpkBCliY
         L3XYs8kNjBwQak+RM/kXW9XD17clK63lPSrah+wTeW6D/WxtOw5xLAdPQDFFvdAFGe3n
         EJ3oRUcn3AiLJXSdPyN+UL/pQdozj023RDOjLuLL60vV1lOTFjgyOXMDmRZoHvQvwBPM
         Xlxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Jones <davej@codemonkey.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	manojboopathi@google.com
Subject: [PATCH 4.4 024/193] Make DST_CACHE a silent config option
Date: Fri, 23 Feb 2018 19:24:17 +0100
Message-Id: <20180223170329.845420743@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217720598222293?=
X-GMAIL-MSGID: =?utf-8?q?1593217720598222293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jones <davej@codemonkey.org.uk>

commit 9b246841f4041f85265dec5f769c017fc36a0d33 upstream.

commit 911362c70d ("net: add dst_cache support") added a new
kconfig option that gets selected by other networking options.
It seems the intent wasn't to offer this as a user-selectable
option given the lack of help text, so this patch converts it
to a silent option.

Signed-off-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <manojboopathi@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/Kconfig
+++ b/net/Kconfig
@@ -384,7 +384,7 @@ config LWTUNNEL
 	  with light weight tunnel state associated with fib routes.
 
 config DST_CACHE
-	bool "dst cache"
+	bool
 	default n
 
 endif   # if NET
