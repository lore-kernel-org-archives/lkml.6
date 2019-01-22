Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C49C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9234D21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548185275;
	bh=g9K8Wcc2yUvCdTJuIwI3ekn8ojLTA9i98LAa6Bv+y7A=;
	h=To:In-Reply-To:References:Subject:From:Cc:Date:List-ID:From;
	b=mL+EjrB5axtT1QiaKmPeTJcv4C+JHFaYNtUhJj3LwR3h06YdnnK4wCIEpOIqSZJp8
	 QR+61rE3fGQktPMYk6PyJk3W5d4LzmypSnGxwZfYYQX4iSru6c5z5gY5m17SIGJFkL
	 HOaQAoVwE+kafjx5JNrXsc+RHsCytYfAoU8wQbnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfAVT1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:27:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:53782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfAVT1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:27:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3C62085A;
        Tue, 22 Jan 2019 19:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548185272;
        bh=g9K8Wcc2yUvCdTJuIwI3ekn8ojLTA9i98LAa6Bv+y7A=;
        h=To:In-Reply-To:References:Subject:From:Cc:Date:From;
        b=YfkwU+L8dZ1HcRZZl+B2BT7SULwmgCSkaginMRjm9QoDbFCkK4o134nbGdVWXDxV3
         qiGzAHH6A7Q6G98gUjoPAMXM6/FNl0FhOP/ktgUfyEFCdJrPSpY3K/8W0f6Zqr6ccr
         XnUn2NEHR4KZW1oAFf0u62qwlm3r8o624uEjDaj4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190122152151.16139-18-gregkh@linuxfoundation.org>
User-Agent: alot/0.8
References: <20190122152151.16139-18-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] opp: no need to check return value of debugfs_create functions
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154818527190.20280.13288000379723139256@swboyd.mtv.corp.google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
Date:   Tue, 22 Jan 2019 11:27:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2019-01-22 07:21:17)
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>=20
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

