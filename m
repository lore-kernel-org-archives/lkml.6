Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670106-1522609022-2-14434668472402927872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522609021; b=os/N4NXA2MAMquV0ru66r8W0Yfb4RPT4zsTzTnOJ6RG9B8pkw4
    D6mBlNKGmSG8yKujcD+q79BGjhRUQLNVOuGOCnEiI0bLd6ogENpvQC/oX1MT3Jzx
    Vu+3edD5VA5SWDCTxwFHTHSADZUzBqsY3eM0li0vSsUcIzx9iAgfse78m1BQc/sO
    tV7lFd0tI+yIj+sSul6TyqrAMEm2EwsPaYRplSpjJIZXY0rZk8FyT5VD6DrfCua2
    FJLisjI2vSIbLKhztZPjJXFUIoSElDKl7daTzCPdvlUE+09Ki6kXKc+2d6O7Oc3A
    TBnI2TPkBgY11p8gXb+eTeRi381WPDgGUZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522609021;
    bh=vHP+2p+2e+mGcmE73b76LXU46n/jbZD00cUSCp8/xgs=; b=Dj4rpupctgHi
    jERaItwUxIEzyolnWBBbqSD3tTKBO0cJUkArStoYOcBb510hpcR2jFwoCDwZdV4Q
    5fGR46D5pwxVzMYvB++7oJF3l2/mCKSU56CugcOIrNsQ4LYI0bdBWIbEtDBRKeMK
    1xCrxIUDfuFvew978qVqr5cTpcXv+/0x9h+JfINAznZS94uN376JgTu9A6xSPBjr
    XJhjs5yF1TtAw1J3twwpZTVHOJwn8eW2u+COG8RsPfjPbJVSMc/AgohX3LoC2vw1
    qdvviLLUxKGLt4mwka5tA1Fj1ZiVDEaA3tbwwClh7jjg8mrBlw752KyFgPuik4uM
    XdB+AMXfEA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAxZ3J3Nv8mHGOFbDPiQKqLGHDT6dlxXMZHLM5mr1JCglMMGoX3RvBbw9n6rlkseJhZTOVx+Lm+DJVhQ9FZqPGqza5KnkB4sZS+paDyLTLfoTPrLvTNC
    e1gaAdNaAMcOHDJ6/PmvD5lvKbxNAPqayxXEafd/63EVGqFPLSfFp2fTxC6JJESuduNdGpIf4kucylkEKQEv0+VapKiBDjPdThzH4ux1myu+vbQPlFAIDLFe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=ooTLGRg96Kw_c14qEj4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDAS5A (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 14:57:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33684 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeDAS47 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Apr 2018 14:56:59 -0400
Message-ID: <1522609015.2654.70.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 085/134] test_firmware: fix setting old custom fw
 path back on exit
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Sun, 01 Apr 2018 19:56:55 +0100
In-Reply-To: <20180319171901.557456225@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
         <20180319171901.557456225@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "Luis R. Rodriguez" <mcgrof@kernel.org>
> 
> 
> [ Upstream commit 65c79230576873b312c3599479c1e42355c9f349 ]
> 
> The file /sys/module/firmware_class/parameters/path can be used
> to set a custom firmware path. The fw_filesystem.sh script creates
> a temporary directory to add a test firmware file to be used during
> testing, in order for this to work it uses the custom path syfs file
> and it was supposed to reset back the file on execution exit. The
> script failed to do this due to a typo, it was using OLD_PATH instead
> of OLD_FWPATH, since its inception since v3.17.
> 
> Its not as easy to just keep the old setting, it turns out that
> resetting an empty setting won't actually do what we want, we need
> to check if it was empty and set an empty space.

That doesn't seem to work either.  I don't see any stripping of spaces
in the generic parameter code or firmware_class, and the parameter
reads back as a space:

# echo -n ' ' > path
# od -tx1 path
0000000 20 0a
0000002

However, this seems to work:

# printf '\0' > path 
# od -tx1 path
0000000 0a
0000001

Ben.

> Without this we end up having the temporary path always set after
> we run these tests.
> 
> Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/testing/selftests/firmware/fw_filesystem.sh |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -28,7 +28,10 @@ test_finish()
>  	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
>  		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
>  	fi
> -	echo -n "$OLD_PATH" >/sys/module/firmware_class/parameters/path
> +	if [ "$OLD_FWPATH" = "" ]; then
> +		OLD_FWPATH=" "
> +	fi
> +	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
>  	rm -f "$FW"
>  	rmdir "$FWPATH"
>  }
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
