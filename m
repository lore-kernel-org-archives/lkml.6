Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Z0Iupy+6OynZwb2Q6ItscxtWpeEG9TIXM+VwJvzIU4mE2OP5tPXSDDfcl+ar8oOmq2MCH
ARC-Seal: i=1; a=rsa-sha256; t=1519218697; cv=none;
        d=google.com; s=arc-20160816;
        b=efzQjLecjyMNuIxe6WM8AzuJVJNlpVrMtoD6vQghehtBCyqvvV/0hWRDC+2M2nEPkx
         58tarxMVF4tKjvIyB50DkWw1WqsEbH2XKU0AfY371W3JdNqCLC7xotTlO6hR+r7w9oWp
         lHLV+A890RwOWpmkQUjClXn2mqeK2Zjw0pShtsy5Hy1t1bzBc7LL0FiRRUhw66PfcANP
         zE5YzU41kjDu5qFF4g+p9wGJcDkbFd4MKLdmwsQpcNUHWEUf9Kmqh3CsfOuKccaX6Muw
         /c3WfU0FXRvKrY5e0imy00fFpFVYgbO5FUSnCVtf41rN8bIEwZqvWO5ntcnS1WWzrleV
         AJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IQRq79fOcJXgQ+ByCF5zGlQ4hsBx73HMQ+0bxMdEwPE=;
        b=s9tfsdyqUXOTYJdiOmBZGGORGOSb06xhNtzJ1m751HkTTktidK2tgCiBc/D96iGYJQ
         kEDgb1yESYFjBSJ/0AC6r7oLmR3a6JjqVxZ8o6FBHvQUaKexvB/oSqUVnjWvSLvOmxoG
         2L9mMuI9VWM9U2Xm8ikvjEqmxKR27F47AO3x3w0wbZCGlpcq+bCKqv5Z3AtoKbyN/Fkk
         +8oskiudhOxz7i5DNh/Pgf74voeocFJdrYGI2NVM0xgfM2+3XyC/6deXWKCLa+dr5vOc
         Sa3WhEE//84iHaCyZlTVa9d5CGuOhx+y3l3Y/AjyTwWdOKT8/JDZdmq0nuZGtAJq2aFd
         SUvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 097/163] drm/radeon: adjust tested variable
Date: Wed, 21 Feb 2018 13:48:46 +0100
Message-Id: <20180221124535.676734374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015181472475587?=
X-GMAIL-MSGID: =?utf-8?q?1593016264647051517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 3a61b527b4e1f285d21b6e9e623dc45cf8bb391f upstream.

Check the variable that was most recently initialized.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x, y, f, g, e, m;
statement S1,S2,S3,S4;
@@

x = f(...);
if (\(<+...x...+>\&e\)) S1 else S2
(
x = g(...);
|
m = g(...,&x,...);
|
y = g(...);
*if (e)
 S3 else S4
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_uvd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -995,7 +995,7 @@ int radeon_uvd_calc_upll_dividers(struct
 		/* calc dclk divider with current vco freq */
 		dclk_div = radeon_uvd_calc_upll_post_div(vco_freq, dclk,
 							 pd_min, pd_even);
-		if (vclk_div > pd_max)
+		if (dclk_div > pd_max)
 			break; /* vco is too big, it has to stop */
 
 		/* calc score with current vco freq */
