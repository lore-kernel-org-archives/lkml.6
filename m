Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522261095-2-18321794980312078910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522261094; b=fzD7KlTMgSmkeRUyHTpY0lCJa4hMsxTA47L4LNveRZclqWY
    qxY59C/WqLuBVSp3tkvyMwm43Q1YR5EPLHl1K9zW0XbLtrjyKTYHW1u8ClXF0Yyp
    8NyqXIE0EMqmgMCvjVY4o6VfonPVCYiugFX7xaA+rJd9azAzH1JY9KQxvc8Bg3+o
    40ktJjFadwcLwjCDMyQJuL3eaPx1Hc9os3ZplsxqMUNrVYvsIT8MVD48eS9S/WFl
    DJ7GtMSoE9Y/WK0DLF4qR/lR9RlR7PAi+iovypSnZsPLOEiE2ib0KBjG/hZ389Da
    SBSqir8uprvMprsds4z8yyo4gUvnheETBu2+fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522261094; bh=CkkA+7SJmu7qArp5DJF8esovR4KZszG+BiP
    ly+pOTm8=; b=gGXktXZb2V4FGjx/NmPf0xr+va3pTGqCSGbKV1ictrY26sieHyy
    VeIKqLf7jiQ6w8Eg3T4aqzZfdsGXIxqBhxUO21S2Vy2gxyCeZ8jgt4Ae2e62RkC8
    iZ5K/f4dbKEpUH4eaMokRV1nLmTUBpT8uxC+oiv16mWs58hxyQfB5KTAiX3Gs1rP
    +wGy9ZQxLsfM3xPFEBdDTqZ5oHgEXeWk0KU01ClNf642c4tfWKVZOdEBTr17HK3y
    Z9netGWrhuhCoMNfNiN71TxkFI/mnY2j3Wl/Zfta26IfRzINGBITpbi+qBQZ7Egv
    ztKFfy9cGQIqyHKYq5zW88wv4m56V1VV0jA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKMtx6RJX1/3yVxnJU4avFCjj9NPacCHmg7wLtm1b1WGcIaApCas69r4YTci70gR4xaWVQ5sptp35YfOc0AC1kxpu0LO9tUDlzIhii3xMB/lBdslGJqp
    qDymisSi2PERJsQaeRYo+sAv2ZYHUBN7q/EeEAJ3Zollyz7s+SAdvRg9rlZSbrU1qZRXuIebw/FkZLs6N2pNin8VFwN/qWPcXkBpZU2FiEWtLijZ+CepRTcG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=hD80L64hAAAA:8 a=vQBBkBfzAAAA:8 a=Mx65ZmiAE_p2lKh0NV4A:9
    a=Eh24YYqaFFIeOi1Z:21 a=olp3Ha9FRK1VHj6l:21 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeC1SR1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:17:27 -0400
Received: from osg.samsung.com ([64.30.133.232]:34590 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753024AbeC1SM5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:12:57 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH for v3.18 15/18] media: v4l2-ctrls: fix sparse warning
Date: Wed, 28 Mar 2018 15:12:34 -0300
Message-Id: <d53d22eb0ea4cdbcb2e7f02d789a01892d8c36cf.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans Verkuil <hans.verkuil@cisco.com>

The warning is simple:

drivers/media/v4l2-core/v4l2-ctrls.c:1685:15: warning: incorrect type in assignment (different address spaces)

but the fix isn't.

The core problem was that the conversion from user to kernelspace was
done at too low a level and that needed to be moved up. That made it possible
to drop pointers to v4l2_ext_control from set_ctrl and validate_new and
clean up this sparse warning because those functions now always operate
on kernelspace pointers.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 87 +++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 7905ad9ffa35..3c4e22855652 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1668,10 +1668,8 @@ static int check_range(enum v4l2_ctrl_type type,
 }
 
 /* Validate a new control */
-static int validate_new(const struct v4l2_ctrl *ctrl,
-			struct v4l2_ext_control *c)
+static int validate_new(const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr p_new)
 {
-	union v4l2_ctrl_ptr ptr;
 	unsigned idx;
 	int err = 0;
 
@@ -1684,19 +1682,14 @@ static int validate_new(const struct v4l2_ctrl *ctrl,
 		case V4L2_CTRL_TYPE_BOOLEAN:
 		case V4L2_CTRL_TYPE_BUTTON:
 		case V4L2_CTRL_TYPE_CTRL_CLASS:
-			ptr.p_s32 = &c->value;
-			return ctrl->type_ops->validate(ctrl, 0, ptr);
-
 		case V4L2_CTRL_TYPE_INTEGER64:
-			ptr.p_s64 = &c->value64;
-			return ctrl->type_ops->validate(ctrl, 0, ptr);
+			return ctrl->type_ops->validate(ctrl, 0, p_new);
 		default:
 			break;
 		}
 	}
-	ptr.p = c->ptr;
-	for (idx = 0; !err && idx < c->size / ctrl->elem_size; idx++)
-		err = ctrl->type_ops->validate(ctrl, idx, ptr);
+	for (idx = 0; !err && idx < ctrl->elems; idx++)
+		err = ctrl->type_ops->validate(ctrl, idx, p_new);
 	return err;
 }
 
@@ -3020,6 +3013,7 @@ static int validate_ctrls(struct v4l2_ext_controls *cs,
 	cs->error_idx = cs->count;
 	for (i = 0; i < cs->count; i++) {
 		struct v4l2_ctrl *ctrl = helpers[i].ctrl;
+		union v4l2_ctrl_ptr p_new;
 
 		cs->error_idx = i;
 
@@ -3033,7 +3027,17 @@ static int validate_ctrls(struct v4l2_ext_controls *cs,
 		   best-effort to avoid that. */
 		if (set && (ctrl->flags & V4L2_CTRL_FLAG_GRABBED))
 			return -EBUSY;
-		ret = validate_new(ctrl, &cs->controls[i]);
+		/*
+		 * Skip validation for now if the payload needs to be copied
+		 * from userspace into kernelspace. We'll validate those later.
+		 */
+		if (ctrl->is_ptr)
+			continue;
+		if (ctrl->type == V4L2_CTRL_TYPE_INTEGER64)
+			p_new.p_s64 = &cs->controls[i].value64;
+		else
+			p_new.p_s32 = &cs->controls[i].value;
+		ret = validate_new(ctrl, p_new);
 		if (ret)
 			return ret;
 	}
@@ -3128,7 +3132,11 @@ static int try_set_ext_ctrls(struct v4l2_fh *fh, struct v4l2_ctrl_handler *hdl,
 		/* Copy the new caller-supplied control values.
 		   user_to_new() sets 'is_new' to 1. */
 		do {
-			ret = user_to_new(cs->controls + idx, helpers[idx].ctrl);
+			struct v4l2_ctrl *ctrl = helpers[idx].ctrl;
+
+			ret = user_to_new(cs->controls + idx, ctrl);
+			if (!ret && ctrl->is_ptr)
+				ret = validate_new(ctrl, ctrl->p_new);
 			idx = helpers[idx].next;
 		} while (!ret && idx);
 
@@ -3178,10 +3186,10 @@ int v4l2_subdev_s_ext_ctrls(struct v4l2_subdev *sd, struct v4l2_ext_controls *cs
 EXPORT_SYMBOL(v4l2_subdev_s_ext_ctrls);
 
 /* Helper function for VIDIOC_S_CTRL compatibility */
-static int set_ctrl(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl,
-		    struct v4l2_ext_control *c, u32 ch_flags)
+static int set_ctrl(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl, u32 ch_flags)
 {
 	struct v4l2_ctrl *master = ctrl->cluster[0];
+	int ret;
 	int i;
 
 	/* Reset the 'is_new' flags of the cluster */
@@ -3189,8 +3197,9 @@ static int set_ctrl(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl,
 		if (master->cluster[i])
 			master->cluster[i]->is_new = 0;
 
-	if (c)
-		user_to_new(c, ctrl);
+	ret = validate_new(ctrl, ctrl->p_new);
+	if (ret)
+		return ret;
 
 	/* For autoclusters with volatiles that are switched from auto to
 	   manual mode we have to update the current volatile values since
@@ -3207,15 +3216,14 @@ static int set_ctrl(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl,
 static int set_ctrl_lock(struct v4l2_fh *fh, struct v4l2_ctrl *ctrl,
 			 struct v4l2_ext_control *c)
 {
-	int ret = validate_new(ctrl, c);
+	int ret;
 
-	if (!ret) {
-		v4l2_ctrl_lock(ctrl);
-		ret = set_ctrl(fh, ctrl, c, 0);
-		if (!ret)
-			cur_to_user(c, ctrl);
-		v4l2_ctrl_unlock(ctrl);
-	}
+	v4l2_ctrl_lock(ctrl);
+	user_to_new(c, ctrl);
+	ret = set_ctrl(fh, ctrl, 0);
+	if (!ret)
+		cur_to_user(c, ctrl);
+	v4l2_ctrl_unlock(ctrl);
 	return ret;
 }
 
@@ -3223,7 +3231,7 @@ int v4l2_s_ctrl(struct v4l2_fh *fh, struct v4l2_ctrl_handler *hdl,
 					struct v4l2_control *control)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(hdl, control->id);
-	struct v4l2_ext_control c;
+	struct v4l2_ext_control c = { control->id };
 	int ret;
 
 	if (ctrl == NULL || !ctrl->is_int)
@@ -3252,7 +3260,7 @@ int __v4l2_ctrl_s_ctrl(struct v4l2_ctrl *ctrl, s32 val)
 	/* It's a driver bug if this happens. */
 	WARN_ON(!ctrl->is_int);
 	ctrl->val = val;
-	return set_ctrl(NULL, ctrl, NULL, 0);
+	return set_ctrl(NULL, ctrl, 0);
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl);
 
@@ -3263,7 +3271,7 @@ int __v4l2_ctrl_s_ctrl_int64(struct v4l2_ctrl *ctrl, s64 val)
 	/* It's a driver bug if this happens. */
 	WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64);
 	*ctrl->p_new.p_s64 = val;
-	return set_ctrl(NULL, ctrl, NULL, 0);
+	return set_ctrl(NULL, ctrl, 0);
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl_int64);
 
@@ -3274,7 +3282,7 @@ int __v4l2_ctrl_s_ctrl_string(struct v4l2_ctrl *ctrl, const char *s)
 	/* It's a driver bug if this happens. */
 	WARN_ON(ctrl->type != V4L2_CTRL_TYPE_STRING);
 	strlcpy(ctrl->p_new.p_char, s, ctrl->maximum + 1);
-	return set_ctrl(NULL, ctrl, NULL, 0);
+	return set_ctrl(NULL, ctrl, 0);
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl_string);
 
@@ -3297,8 +3305,8 @@ EXPORT_SYMBOL(v4l2_ctrl_notify);
 int __v4l2_ctrl_modify_range(struct v4l2_ctrl *ctrl,
 			s64 min, s64 max, u64 step, s64 def)
 {
+	bool changed;
 	int ret;
-	struct v4l2_ext_control c;
 
 	lockdep_assert_held(ctrl->handler->lock);
 
@@ -3325,11 +3333,20 @@ int __v4l2_ctrl_modify_range(struct v4l2_ctrl *ctrl,
 	ctrl->maximum = max;
 	ctrl->step = step;
 	ctrl->default_value = def;
-	c.value = *ctrl->p_cur.p_s32;
-	if (validate_new(ctrl, &c))
-		c.value = def;
-	if (c.value != *ctrl->p_cur.p_s32)
-		ret = set_ctrl(NULL, ctrl, &c, V4L2_EVENT_CTRL_CH_RANGE);
+	cur_to_new(ctrl);
+	if (validate_new(ctrl, ctrl->p_new)) {
+		if (ctrl->type == V4L2_CTRL_TYPE_INTEGER64)
+			*ctrl->p_new.p_s64 = def;
+		else
+			*ctrl->p_new.p_s32 = def;
+	}
+
+	if (ctrl->type == V4L2_CTRL_TYPE_INTEGER64)
+		changed = *ctrl->p_new.p_s64 != *ctrl->p_cur.p_s64;
+	else
+		changed = *ctrl->p_new.p_s32 != *ctrl->p_cur.p_s32;
+	if (changed)
+		ret = set_ctrl(NULL, ctrl, V4L2_EVENT_CTRL_CH_RANGE);
 	else
 		send_event(NULL, ctrl, V4L2_EVENT_CTRL_CH_RANGE);
 	return ret;
-- 
2.14.3
