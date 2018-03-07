Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3646879-1520439247-2-10901407998829859258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520439246; b=wMXOEsbYTstKZ1ueRzBzWJKPak4WWy/ugsWRQMo2YphMm4f
    IThZLjRXHBNhpNMdgHCTnwkp6BAOaA7EJuKEO5iv3iBW4+rpn1a2VBA+241vmW4u
    FOsVsXFuyLSCN1W3EhWMYGmXKZPBiRVoog4OcACwa/N9sdBdu5BHS0FO4vqR8s0S
    72RsBmRJm/0sibRoR/IQnkc/d4uKdTGDgKl5sXb5iLwJpLfEHmDN6Bcylp60GwUr
    lywGPKq0ymmbXyLAm/o0i3uwiUp7vcdXybLw7vap4EioMUfQj6HPtxrZO/K7HWS2
    /eJ45noMg2L3ubdgPt1cJv7ySzoo14bCzSnSooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520439246; bh=4nRY5lFFez1Xn+ouSe1DRmrP6OnrDHn8wmFGn5
    aojro=; b=Nc/6NglU8k91ojduen7RM78Lbv5sxMHqP8g1hta0YSXtLo+RGFJ/rF
    4ms3U3TrzB8Nbi0KWuzhLPbuPcl6FguAm5KUSIb0G1VHVAjJFeMvBUrbkyplv6G7
    OEiyP+X23aoxhP2Ldcb5y0rOCG1NkdIvi9pdbmGFLxzxmLk5kt/PT5RRw9iK83SI
    jXSG2SyOHb4lj7+oYnoj1WWw+GyrVea7YAQvX1wS/vDbW8hpWhpXggIOoBZTRIdY
    WFpYlpnkDctEqVWur/Lc4v8GJ/iDR5xKaYop2+43/N2E/MyvjGMaFjwZ53gfhDv+
    1YsXcfhiQ+9x63keMAVvLqliNs2g7RXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933768AbeCGQOE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 11:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbeCGQOD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 11:14:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524152177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsABl0PKYOXvrDy9QrEGBDAuXCMP/JfF5ZGdl5obKnBXGvSofCQ+boc+kBN6EJX1aLsZ3SrjA0FT4/CsUbuHOw=
MIME-Version: 1.0
In-Reply-To: <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com> <1520412597-30545-4-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Mar 2018 10:13:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5bO1MpHvATfRAGi9=cHzBf3n6AVD5=JVfAzt0DnGfqw@mail.gmail.com>
Message-ID: <CAL_JsqL5bO1MpHvATfRAGi9=cHzBf3n6AVD5=JVfAzt0DnGfqw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] tty: st-asc: Update tty alias
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 2:49 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
> must include only lowercase and '-'.
>
> After having updated all STi boards serial aliases from "ttyASN"
> to "serialN", st-asc driver need to be updated accordingly as tty
> aliases id is retrieved using of_alias_get_id().
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> v3: _ update st-asc driver with "serial" alias prefix and keep "ttyAS" in second choice
> v2: _ update st-asc driver with "serial" alias prefix
>
>  drivers/tty/serial/st-asc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
