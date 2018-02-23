Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFjjs4zC1foHdSMb/BFQgFmwwgTLYPEp7vl1a5nv4SCPrej5+KOLvaQAxhkbS5BT8KSrwc
ARC-Seal: i=1; a=rsa-sha256; t=1519412217; cv=none;
        d=google.com; s=arc-20160816;
        b=0nkOcgVutgZVtm2JU15aB6+9D5BOQ8q6X0guzvZOuAoBFquFpShu8ujUatxa45tL8L
         iU+9LlvcVIyxo115WIZOW7UonBnNqLrzhyOrD9scDr3Cqr6orsb/BGWDM98CkjbuWbZ2
         gT4H3AMQcE5+noPOg0eIajYybkOrcwvhRw6lq43meomnO9NBr/SucLU/p9JlZcCaMULp
         eCFrRX6xZkVUyIr2Pt1Ih1WNPCcEk12NSBDaoIr8rDNG+HsQjtcbhTUq5KnLG4imFuug
         qRWFUpRjDIHIdx7vhij0p20jO94OdSP5nc7Wa8D5fZgOMi2MxSbGvxN2NQHPeXjfFcb8
         yhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4jCaWmR1rkbLCuvbJF91Bwk0drbB9GDa2KQsxvTIgqk=;
        b=NLeQGOFmcO6RU2eZb9jUowzp6zu4xb5IX30tHme+A5BUkamWCYwqoziJP3q07UsvrO
         M7435m8XHBsCjGfSTmx2HHub6zSRPvH649dLCJw+j6jLNDK3KaHu6f1jFUYaRdrWVRhy
         a+Vx4ncNpGFeObaX4BjftRcgnOrwB8ir6ohPV1MjCDXc2Et9y51TbMpzOogoD4jp1nhQ
         uNivz/ZX3ZxFp62KcpsnoJcwL3Mk7sQ6NPijcZbLF+G+Y39i9VAG1oiePO4WQQ9CC2QH
         eux1k9+Axlg6GbwWYrfMeJoYi/BgEliutQ2yVYiVUTqNRDBZdq6qCyO8it0bevmSzJy3
         WULA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 155/159] drm/i915: fix intel_backlight_device_register declaration
Date: Fri, 23 Feb 2018 19:27:43 +0100
Message-Id: <20180223170801.702996437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218626816907145?=
X-GMAIL-MSGID: =?utf-8?q?1593219185550559780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ac29fc66855b79c2960c63a4a66952d5b721d698 upstream.

The alternative intel_backlight_device_register() definition apparently
never got used, but I have now run into a case of i915 being compiled
without CONFIG_BACKLIGHT_CLASS_DEVICE, resulting in a number of
identical warnings:

drivers/gpu/drm/i915/intel_drv.h:1739:12: error: 'intel_backlight_device_register' defined but not used [-Werror=unused-function]

This marks the function as 'inline', which was surely the original
intention here.

Fixes: 1ebaa0b9c2d4 ("drm/i915: Move backlight registration to connector registration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20171127151239.1813673-1-arnd@arndb.de
(cherry picked from commit 2de2d0b063b08becb2c67a2c338c44e37bdcffee)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_drv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1708,7 +1708,7 @@ extern struct drm_display_mode *intel_fi
 int intel_backlight_device_register(struct intel_connector *connector);
 void intel_backlight_device_unregister(struct intel_connector *connector);
 #else /* CONFIG_BACKLIGHT_CLASS_DEVICE */
-static int intel_backlight_device_register(struct intel_connector *connector)
+static inline int intel_backlight_device_register(struct intel_connector *connector)
 {
 	return 0;
 }
