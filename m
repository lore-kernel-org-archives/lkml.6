Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224K5+X8BlJekf+v9payjY2ggTqVd+bEsKkYMwZ/T5goJhUmx+7SSgXvVRGNvURqukCbapko
ARC-Seal: i=1; a=rsa-sha256; t=1519218129; cv=none;
        d=google.com; s=arc-20160816;
        b=FIEa4vKl4limLwFMlwZPCDZn9Aoh2omYEuWG8eCwhU0a2OG0EbfQwt5Wq90ZpuLS8G
         pz39p+/bOW5+GxouVCIqkxgg37n0QLGPPFqHkFqgvDFm35Gl3pHflpfOLFjTpwd8fGLL
         WNzJJwoK9uJiz7rhYO+zIIz29cC0lt5b0+G2bGkyQT1WwxAD0cf6QHatLe3O0b1jXg1R
         XmG3NH9xUdw8XApMlRp7mn0bYfRq+cM2W91I4nZwz7IY6+C6My//P8pdCnEycgH1tlw8
         IJr1bhY8u5FYGhjnZDuyV5eQ350A2pSbdlOE2LuQxJP6SYNnRcqqi8sFcUyFvlRkkQnn
         3vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c8+qvxUeJ336QOYR8TrJzE9CmGg7J7G7Bido8ZOeCbI=;
        b=wqB1maWkrFk9fgSoN7Cw+MNu36TXpqX/rfncH2hx4V88POM4JYN75pU8ES4uP464nq
         h1dhSlxPZEnRwhRzBIIW2m8/bXj9/j30FLHxiCwbXI5pCZp2K9HHMeD7taA3K3eQUXgy
         F6p3XpPmcsiiD0Kx3JdiCzz73PvRC7afsOlYCqHk2qn1Wg7wiHgCLgp0otoJW7q5LLqG
         Nhlk9zZh4cx7itAb9gEah9MWxVUiIKk4Jd51O4iRTJZnY3WGRzQ9w2to0AXIZa3CZSB3
         3PFEYQHXQXpj2PcAbJov0w0j5ZZMPuOdUCyWGDQ7xLf6QAPovvOZgBVf6KFXLuPOxIK5
         pGrw==
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
Subject: [PATCH 4.14 097/167] drm/radeon: adjust tested variable
Date: Wed, 21 Feb 2018 13:48:28 +0100
Message-Id: <20180221124529.650795019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015181472475587?=
X-GMAIL-MSGID: =?utf-8?q?1593015669039552994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
