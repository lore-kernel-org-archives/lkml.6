Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6fQv1+jsmMcqkhElvk3jsRQVvC9wYQLN/GgKD++DyRURcXUoGa2ed49+ZT8gX7iYiJ+NL
ARC-Seal: i=1; a=rsa-sha256; t=1520954892; cv=none;
        d=google.com; s=arc-20160816;
        b=IZACf8Uu8lqdaVbyuA49IUstcMwTP1+5mI6lyvcKc3g6QVtabdo7TOEjF1aL9e8sCD
         sS+e+Y1gHq8FqDniYmA7lW0tTtPycx+L1qPf3w2M74UkQeWxwVu/UqbU7MTPZ+lNneWA
         dM/eLRy8++x0H7H9GK6sdCYpGjzjM/1lgn1TamBShk4O9YTF9ZQC0Dn5OroUnXhwvB/t
         8K2pjXuEBfaWBPxgwO0zyKjg0mU2gPFwqze3uig20AMragh1mI89zf3UFnRAkBFQ+ooN
         42XBVoqchIk0b1mTx/+0NRiPozaTIkiTU/NKQKRBLQbbUfXAxK8JUs9RZ9FHkFE9K2zn
         hjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zRdBfLbG5Z3zfvNGxnAd0cxzMq8HKKCcxRaEnyXBZ2I=;
        b=AEZRag4ElI0/Je04e85BU1oCgw7p80f/fxKV8gXiWaQkhQ+9SixpSO69dYD9DswuKM
         8ryT+zf0M2hNsHjadh/LN9hYGqfYwi0mE2ESr2e5Tnf411AWnIowzCzf4yZ8+c5b1Aax
         Ohb/GJYcKJvrwcFjQZC/XRRO1RqxvYT7t53wy1j4PqzwqEgFUyO9JyaATUGw21ddz6Lc
         zqsXkD97yzBYW+Eu+DNwPo4TuG17cb1v36GrPMX+2FSuhrKIVFSM2V/sHwYAKplL9jpr
         C3sdOWOiUwjuoW2mmeQ7hwWuCbMPC0wSkEzZhHr3amUc3UZaXGKXoCWDKPoFYVgi8Oe2
         v+bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jaswinder Singh Rajput <jaswinder@perfectintelligent.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 009/146] drm/i915: Check for fused or unused pipes
Date: Tue, 13 Mar 2018 16:22:56 +0100
Message-Id: <20180313152321.327491132@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836797675864034?=
X-GMAIL-MSGID: =?utf-8?q?1594836797675864034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Kahola <mika.kahola@intel.com>

commit 9965db26ac0548648309f506dc155a92daa2158f upstream.

We may have fused or unused pipes in our system. Let's check that the pipe
in question is within limits of accessible pipes. In case, that we are not
able to access the pipe, we return early with a warning.

v2: Rephrasing of the commit message (Jani)

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103206
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jaswinder Singh Rajput <jaswinder@perfectintelligent.com>
Suggested-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1513584243-12607-1-git-send-email-mika.kahola@intel.com
(cherry picked from commit 0b7029b7e43fda1304c181a3ade0b429b9edcd9d)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -754,7 +754,7 @@ static struct intel_encoder *get_saved_e
 {
 	struct intel_encoder *encoder;
 
-	if (WARN_ON(pipe >= INTEL_INFO(dev_priv)->num_pipes))
+	if (WARN_ON(pipe >= ARRAY_SIZE(dev_priv->av_enc_map)))
 		return NULL;
 
 	/* MST */
