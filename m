Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2225902-1522782411-2-6406111821970393630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522782410; b=OMYRoZp2kG39BUzs55w7Lu9ld58ZpHkOnFgJFj/uM5htQNTF+O
    CNX7rKPwhKg6f2Uu/Zf0XuCI26/g+0bb+uujwaveGzCSN7rxX5EG7aWm0O3jv4md
    YQfYjtYcoaTmqB4wxO4di0IxNNQpziN5LBX6WDaDEZMy81+HJgLADM8bMm/0qEGs
    UdqUfZgNv7X6Z5EqzSS4L85E75DvT5Vr3p6UKjjNPiNROyQ2J5ZE9HSlxZJi/zRn
    0v3UwyrkFGQU32fUiqN6jjkBEK8+47R6WfpAmiL9I8F5W9JPW8HqqTLseevtKAUf
    RPNcE/+L4FHnLiO1vLLKkW/6RSFWV6EhoDEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522782410; bh=wf0yo06GpBz
    mnNSsJmHf5hj07BvkGxTWmoFx0ttvMco=; b=KqNxHMK8lX+MHYj+8laML3KmKaT
    /l3L85RlQ7Cn0mgUlimeFYqqFG/9l18hPHLkb8gTD5vF9whVOs1Yh1i2rkf20sV2
    LpkGnK9Zx7K85VzDvWBbQQWF5gmY0rC6yAKe1wISy3/IPKmczpGIt1L8OB4aBjrh
    VolehUAdwcWiSocyLAR78q4sEMBii0dFzosC4P0MtBr17QWuAlalFBZw5pDwIDa2
    8PkKuJPa/LQKZkF/TKyqPNPKMGjYeRvmfOWOfmFx6+T/rmRTlZ0zH2jh2Lk6OymE
    Ed75+zYduE5k00jvTvy5xg9aDPagfpu2SFsvEihwSEgIt4K1pPr7gq+tXXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCY0VQN2V+FuS/7ALZZRGintJZ2L7YZ4wVDHKOlCLMKEFiF5ItE1Voj8WYAbngY9iSbo/zVuM4z1JyQHhKTxdbpHPokq6pwqPjlGA7kgUz8BCk+XBLlw
    OeXlNd6G6CWJZuYck4dWOFXFuebEkfb8xtpk5bp4GJ5lYbaP3uqKkDLRLAXYPyorExer6soolWfu26Gc3WsYdQzcIcztMM2cbM436eTtVeKP2AvIBASfIQnx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=yLtI2avdtoB1nHopyCwA:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753106AbeDCTGs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 15:06:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:38620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeDCTGr (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 3 Apr 2018 15:06:47 -0400
Date: Tue, 3 Apr 2018 19:06:46 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 085/134] test_firmware: fix setting old custom fw
 path back on exit
Message-ID: <20180403190646.GE30543@wotan.suse.de>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171901.557456225@linuxfoundation.org>
 <1522609015.2654.70.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522609015.2654.70.camel@codethink.co.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 07:56:55PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:06 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: "Luis R. Rodriguez" <mcgrof@kernel.org>
> > 
> > 
> > [ Upstream commit 65c79230576873b312c3599479c1e42355c9f349 ]
> > 
> > The file /sys/module/firmware_class/parameters/path can be used
> > to set a custom firmware path. The fw_filesystem.sh script creates
> > a temporary directory to add a test firmware file to be used during
> > testing, in order for this to work it uses the custom path syfs file
> > and it was supposed to reset back the file on execution exit. The
> > script failed to do this due to a typo, it was using OLD_PATH instead
> > of OLD_FWPATH, since its inception since v3.17.
> > 
> > Its not as easy to just keep the old setting, it turns out that
> > resetting an empty setting won't actually do what we want, we need
> > to check if it was empty and set an empty space.
> 
> That doesn't seem to work either.  I don't see any stripping of spaces
> in the generic parameter code or firmware_class, and the parameter
> reads back as a space:
> 
> # echo -n ' ' > path
> # od -tx1 path
> 0000000 20 0a
> 0000002
> 
> However, this seems to work:
> 
> # printf '\0' > path 
> # od -tx1 path
> 0000000 0a
> 0000001

Not sure what you mean, care to send a patch?

  Luis
> 
> Ben.
> 
> > Without this we end up having the temporary path always set after
> > we run these tests.
> > 
> > Fixes: 0a8adf58475 ("test: add firmware_class loader test")
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  tools/testing/selftests/firmware/fw_filesystem.sh |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> > +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> > @@ -28,7 +28,10 @@ test_finish()
> >  	if [ "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
> >  		echo "$OLD_TIMEOUT" >/sys/class/firmware/timeout
> >  	fi
> > -	echo -n "$OLD_PATH" >/sys/module/firmware_class/parameters/path
> > +	if [ "$OLD_FWPATH" = "" ]; then
> > +		OLD_FWPATH=" "
> > +	fi
> > +	echo -n "$OLD_FWPATH" >/sys/module/firmware_class/parameters/path
> >  	rm -f "$FW"
> >  	rmdir "$FWPATH"
> >  }
> > 
> > 
> > 
> -- 
> Ben Hutchings
> Software Developer, Codethink Ltd.
> 
> 

-- 
Do not panic
