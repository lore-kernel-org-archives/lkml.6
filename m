Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021282-2-6117914442541609464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021282; b=bhzgHatkD3mEsjoKt3Kb6ri7QjLhh4u7SWI+2jbEETTv8dQM8r
    HnaKErxTKbJ+bQWO7czZLfqiKQ229zhxjO5uXRyu9aCzJljWqb6hT+L/n8dm2hEP
    u9SsK/44zeaQKRRTQtriR4ilY0EYPyfZlHhmpte7krb5YnoJyJrJCAfefmNQhkWp
    tdar0Y4Hnoh74KwvCUcvmU29VKYr7WTM/h33Hg01Xawa1YYQ9Zuy3eNHEpL5wnmN
    lF/6uWSVdNL2M6VElnQPbxA9jdZIxLZp6UPLirLuxiC3pf7Uvi2LoFQ5O7FE4Z7y
    ZzkesbvAki4v3veQ//SSTwkvhLSGm/RIScYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021282; bh=IEq0IJX++tDnLzNIgBImo6ZY4ta4lI
    bZv0wmZij3vRw=; b=V34orT6eKH/eoAD9tH9RwWBQUDq5RuiuBlUd9D1+/lpzPE
    +ONmKmAa7IYuI5RfrlUPgJpck3AUAtuxQ6XW/I3B0f1M9SrZHyRMQxT3UGemSSjO
    BPTLhEE+O1TvXp5FeMgm3qI/+bwLchgmUVWLe3W+q1WtVDleSFSlH2dirZf+T0jf
    wOnmyQKG9i7kNDX28kl/e/obebyKNw/x4G+xKTCEwGIfHfWfqhixLqc74qfPz8/g
    IfoQPMEPgNCgUTZ9VEwlGqb5EHZfqBHI2DzjIP1C/zVwXtYYBmYdr2CXArH/Kobf
    Immq1btT6iNuhfcuXlthxzvurzYzhsbSs/GMRdJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIzABIoXmdKeJiO/Tar69qaN4VMcWCvFPywiEl/Y02G+86vR+S0i0CgYt4WOF6RKuWaSUqOe8XTxidTFkurc2IR6NCtWim3BO51v6rfpsqWGlGG8obcQ
    jqf/x+y/bkiVAioMnk7rx7ku+l7m7dYT0sGJ7x/ejgihCWZ4hS1CBP//hdBqz7FxuTrjRRMraR2QFrR56aUdmc9vs/lIVCNJfC1hrZyaZCHSxBJxwj/flmCv
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AUd_NHdVAAAA:8 a=hD80L64hAAAA:8 a=vQBBkBfzAAAA:8 a=ag1SF4gXAAAA:8
    a=Mx65ZmiAE_p2lKh0NV4A:9 a=j6EKuQwrLAOcOYv9:21 a=9U8j-r_ESze9fWrj:21
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeDFN16 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:27:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeDFN14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:27:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 3.18 71/93] media: v4l2-ctrls: fix sparse warning
Date: Fri,  6 Apr 2018 15:23:40 +0200
Message-Id: <20180406084228.151156522@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c |   87 ++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1668,10 +1668,8 @@ static int check_range(enum v4l2_ctrl_ty
 }
 
 /* Validate a new control */
-static int validate_new(const struct v4l2_ctrl *ctrl,
-			struct v4l2_ext_control *c)
+static int validate_new(const struct v4l2_ctrl *ctrl, union v4l2_ctrl_ptr p_new)
 {
-	union v4l2_ctrl_ptr ptr;
 	unsigned idx;
 	int err = 0;
 
@@ -1684,19 +1682,14 @@ static int validate_new(const struct v4l
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
 
@@ -3020,6 +3013,7 @@ static int validate_ctrls(struct v4l2_ex
 	cs->error_idx = cs->count;
 	for (i = 0; i < cs->count; i++) {
 		struct v4l2_ctrl *ctrl = helpers[i].ctrl;
+		union v4l2_ctrl_ptr p_new;
 
 		cs->error_idx = i;
 
@@ -3033,7 +3027,17 @@ static int validate_ctrls(struct v4l2_ex
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
@@ -3128,7 +3132,11 @@ static int try_set_ext_ctrls(struct v4l2
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
 
@@ -3178,10 +3186,10 @@ int v4l2_subdev_s_ext_ctrls(struct v4l2_
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
@@ -3189,8 +3197,9 @@ static int set_ctrl(struct v4l2_fh *fh,
 		if (master->cluster[i])
 			master->cluster[i]->is_new = 0;
 
-	if (c)
-		user_to_new(c, ctrl);
+	ret = validate_new(ctrl, ctrl->p_new);
+	if (ret)
+		return ret;
 
 	/* For autoclusters with volatiles that are switched from auto to
 	   manual mode we have to update the current volatile values since
@@ -3207,15 +3216,14 @@ static int set_ctrl(struct v4l2_fh *fh,
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
 
@@ -3223,7 +3231,7 @@ int v4l2_s_ctrl(struct v4l2_fh *fh, stru
 					struct v4l2_control *control)
 {
 	struct v4l2_ctrl *ctrl = v4l2_ctrl_find(hdl, control->id);
-	struct v4l2_ext_control c;
+	struct v4l2_ext_control c = { control->id };
 	int ret;
 
 	if (ctrl == NULL || !ctrl->is_int)
@@ -3252,7 +3260,7 @@ int __v4l2_ctrl_s_ctrl(struct v4l2_ctrl
 	/* It's a driver bug if this happens. */
 	WARN_ON(!ctrl->is_int);
 	ctrl->val = val;
-	return set_ctrl(NULL, ctrl, NULL, 0);
+	return set_ctrl(NULL, ctrl, 0);
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl);
 
@@ -3263,7 +3271,7 @@ int __v4l2_ctrl_s_ctrl_int64(struct v4l2
 	/* It's a driver bug if this happens. */
 	WARN_ON(ctrl->is_ptr || ctrl->type != V4L2_CTRL_TYPE_INTEGER64);
 	*ctrl->p_new.p_s64 = val;
-	return set_ctrl(NULL, ctrl, NULL, 0);
+	return set_ctrl(NULL, ctrl, 0);
 }
 EXPORT_SYMBOL(__v4l2_ctrl_s_ctrl_int64);
 
@@ -3274,7 +3282,7 @@ int __v4l2_ctrl_s_ctrl_string(struct v4l
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
 
@@ -3325,11 +3333,20 @@ int __v4l2_ctrl_modify_range(struct v4l2
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
