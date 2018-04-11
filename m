Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ufo08EzxADSQS5YgvtHuR8+YDDnbEfQkk4uboW7Tb5nfdouM6LVn9+QRmW9pZh4VyRdNq
ARC-Seal: i=1; a=rsa-sha256; t=1523473198; cv=none;
        d=google.com; s=arc-20160816;
        b=ozl8IjmllFUt+IM+hIdE/wgsOn4N6/DaJHqz5B0ppoKH4dMwfkyAj3Q+RNV53kLHly
         oOrpm55641YCEH6Cx0IA8ULC/0qQKAFdzOOoDyoxUw5C1Un3zEmLNpufbOYLiYao0pni
         wOP9QaP21oOjsQedzDe9GaWUZZWlA8uEQ4D9uRLakOiAEDFEAwAunyJu4HdgzatoCF+x
         xSywHXLfXYvO+M6vombXis70crxOVqstmQ8E3jmvqQiGGDqLJOC02RAGSyR25Si0u1Yz
         Sr5/kPV+KUEKfxJYOKX8OUL/a5BK3UlYBlJ3Q/HYdtkXOropBoeiSDS03lZ8ns5UBNuG
         5prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RAr3f76AOTCS5FgD/G7DB31W0uljAZ0DIWc89l2Egng=;
        b=oiIWYFK/CG9hmF3nWjMmNFQVyP4ZJhcluRgmzhSZdgcAca6AhEhQJNYofYUE1HGz6E
         UX/67LIsPXJu5UhKxrd/XTpCZpyyhUjMqdk7g/elUlis2OsrdWP+ddVIzOk/V6Vivb6y
         2kBng527BTwMeOswG0gmJwSeYsoHZCI3u6X1QtI6h9Vse8c+DxDHfypxlYtwmnx9OIRQ
         cHWwp+w3BMwRq/dzpQjc7vPWj92CUsZ2XaTkTPsyM+fgWS6LkBPalUTtyBLBnmzYB7hN
         Jjoqp3iogjCV+cxZIYSN22S4/t+5ik15YQclmG20m0rHk2Ku4iL1Fo3Y5v8Mxs4HtLQt
         kDhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 161/310] i40evf: fix merge error in older patch
Date: Wed, 11 Apr 2018 20:35:00 +0200
Message-Id: <20180411183629.319116380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477432629164514?=
X-GMAIL-MSGID: =?utf-8?q?1597477432629164514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>


[ Upstream commit 155b0f690051345deefc653774b739c786067d61 ]

This patch fixes a missing line that was missed while merging,
which results in a driver feature in the VF not working to
enable RSS as a negotiated feature.

Fixes: 43a3d9ba34c9c ("i40evf: Allow PF driver to configure RSS")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -154,6 +154,7 @@ int i40evf_send_vf_config_msg(struct i40
 	adapter->current_op = I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
 	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
 	caps = I40E_VIRTCHNL_VF_OFFLOAD_L2 |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
 	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
 	       I40E_VIRTCHNL_VF_OFFLOAD_VLAN |
