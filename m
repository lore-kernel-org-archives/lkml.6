Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524841205-2-14533143847298225220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524841205; b=kvgDds8SChMPP8QcF5DcwCD8gQ4gK8X+m4plknNa2/wdgNvI3f
    KdhyuqgSvgIJ++34P8y87LuFNVhJ1RMwTuEz6iUQyNnwYDAs1a0oa0kYbK2E5g/s
    GWSzVqKo+Zp0I8cLv3osD5l84bPCDn32oUeoHqPHKIRBpGmsdhPJYwErS+fxAngz
    zEIJkNMmZ2eMvv07rYtGndhkOR89bSxH4zbRlXdzrdsJhs5HfK5GwJvc/pd9m+/R
    yYW8wCyvern/RXkF1YRrmnExVkO1HwcbhgDGYtHDWRqecQWGe1n2PUdyZXyAEMc2
    7G0Px06wBwk8f6o2cosLHdKZHN2L+ua1h6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524841205; bh=zV6Iw
    wczuMDia4hBYnmiQ0qGNxVni9GlO4p1v/g363g=; b=D2i4n6cL02fzRUs0NoSTJ
    /FvhhOwV3LP1qO+ibHaXRNEnfsWULXwOHSil0AC7PKLJXuCfVBS+aqqsudp9SAVj
    5Xw1GqtV6txeNQV3oO5a96DpFlXPzZuJ7eNsTVveptIBnFXpRpHX8Kd5qGbJYQBJ
    YLsvtW4PLf1dtlrQZ/BHt83VtELWP3YHoA9bOZUGHF97ToqWd4b3bbGL+1Muh7CA
    k3Sh+xJwKHOTT9VQJWUxU0ss8BZ8ZUWDZHMYtu2bz0do9xxG48891CKPXOwaD40T
    uUAEkzJqKmgVt7s8G3xFnP8JCPihb4dFS2ldYPeS5zVogZtWoG5L3aCY/mOrbkE7
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGa2rgpEEJ6xSMiJ8hKxnwyAeBl6jvXrd8NnQrh1CYy7TLfdqoBfja9E5oARtj5qwyetV+5uwFodAjnpjDLLwDt+fUbtHuSljy61E0pdP4OTUHnTMknh
    t2s+GroWyMHR6hL+qV9FqVVLKcTYF8O8+WAAWrIV2Eyv0ytXPGvVjc16iL7zFpB2OLuQ5j4iHEmUdyx5rAylkWFF5pDTZxmmcrnTrfyQog4n6LhVYFKISMfB
    +GWaTIEViO+oFjpzcYorQQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8
    a=4sjfequUzrh1EeGaDgkA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B78204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:59:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH v4 3/4] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Message-ID: <20180427145948.GB12750@kroah.com>
References: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
 <1522174414-30380-4-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522174414-30380-4-git-send-email-roy.pledge@nxp.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, horia.geanta@nxp.com, arnd@arndb.de,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 stuyoder@gmail.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 02:13:33PM -0400, Roy Pledge wrote:
> Move the NXP DPIO (Datapath I/O Driver) out of the
> drivers/staging directory and into the drivers/soc/fsl directory.
> 
> The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
> hardware on NXP DPAA2 devices. This is a prerequisite to moving the
> DPAA2 Ethernet driver out of staging.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Ah, this needs to go in before the ethernet driver can move out, sorry
about that.

Can you redo these last two patches against my staging-next branch so
that we have a chance that they will apply?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
