Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AB8JxZrT343T6rKxnsXcerK3PX3Q8dZ998wrwv94QbMgE2JRKL2iSlar+XemntcL13n/mVJrFisw
ARC-Seal: i=1; a=rsa-sha256; t=1526369522; cv=none;
        d=google.com; s=arc-20160816;
        b=v+9YJ/37ZUG3rJ2szgRlM+5IlK9yoFF/xGhcNxVjKkvo7mUQHD+tn7Pw+UNMdqhbNl
         Y9YaHvIVFyCU9fNbPu8Ns6f2AaMAMBlnXPv1R1jwpJz1Bn/Ll4lemkafWQf6nUuIm8cm
         8Sc7D9x9dxdsqP+Bs88jnz2pwTjKNqseRpCOUitB5ru+PCeN9HOLdyrmnpKc6JHs0MWV
         K20MEyutTPHCVsj27RPcplE9Ha6zbbD+hZDzbx/k2v2dDNe8UUVlEXSx4Nx3IFV4ZxxQ
         1g+2XaVQY5n8bNoj+PPai2Z0H1Ke6Vrs7a5LNeWhW+gwx7GJa7T0A8EHCDB2y952oKhH
         3UtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vJVwNVLW3Cs6LN3Sx6lxnJWpSaha2fFw7UpmgxDnlYI=;
        b=vDs7t2CDeiCPdy9ytESYzWZjCTEQms+dtYAZHOwVWL3oaOT7nyo8MgLEXXMOXXvdB4
         xDcpKLaUeehA/yq1CwSBuNzeXHZ9ErbCfxmz6Jtb5tk9NXp4/u/HT9KIhJRkOTsky3kr
         ngfjUo+fO9yagZFlU1fvEwnXFq55fbhIGbUUL9y6EgeLIZkKp1gyT9zRGyx0QDKIEYux
         xDG1b7H1EjY0cI07DQI/FsCxrCwnt+0tLt7U4qcjltgA58v5aXwIinJRD89DC6JfHGO4
         iYHeRdgVBKZD643IYoDyp7Za70yyQa0bXYQKYg7BTJBF9Gi6OJn/RCJrKa05Tt2g2WVD
         LuSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=azOG93vK;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=azOG93vK;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <878t8l9y6j.fsf@linux.intel.com>
References: <20180131155718.5237-1-a.hajda@samsung.com> <CGME20180131155734eucas1p2b55ad1aab1d5086566dad7a79b25ccf3@eucas1p2.samsung.com>
 <20180131155718.5237-2-a.hajda@samsung.com> <878t8l9y6j.fsf@linux.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 09:31:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPffEz9Qn1FsGhKKHZqPo79J5svAhNSSHrHwsLjjgWkbNA@mail.gmail.com>
Message-ID: <CAJKOXPffEz9Qn1FsGhKKHZqPo79J5svAhNSSHrHwsLjjgWkbNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] USB: dwc3: get extcon device by OF graph bindings
To: Felipe Balbi <balbi@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
	"open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Inki Dae <inki.dae@samsung.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-kernel@vger.kernel.org,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591124175136204750?=
X-GMAIL-MSGID: =?utf-8?q?1600514448456963604?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 9:26 AM, Felipe Balbi <balbi@kernel.org> wrote:
> Andrzej Hajda <a.hajda@samsung.com> writes:
>
>> extcon device is used to detect host/device connection. Since extcon
>> OF property is deprecated, alternative method should be added.
>> This method uses OF graph bindings to locate extcon.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> Hi all,
>>
>> This patch implements alternative method to get extcon from DWC3.
>> The code works but is hacky, as DWC3 must traverse different DT nodes
>> to get extcon, in case of TM2 it is USB-PHY and MUIC, but other
>> platforms can have different paths.
>> I would be glad if it can be merged as is for now, but additional work
>> must be done to make it generic.
>> I guess on DT binding side it is OK. So the problem should be addressed
>> in the code.
>> My rough idea is to implement kind of extcon aliases/forwarder mechanism,
>> ie. USB-PHY will expect on its output remote port extcon, and it should register
>> extcon-forwarder pointing to this extcon. This way DWC3 can look for the extcon
>> on its PHY phandle, and it will receive via forwarding mechanism extcon
>> exposed by MUIC.
>> As I said this is rough idea for discussion, other propositions are welcome.
>>
>> Regards
>> Andrzej
>
> I need someone from devicetree to review and ack patch2 before I can
> apply them. Either way, this doesn't apply:

The DTS patch will go through arm-soc tree, I'll take it. The DTS
patches are independent from drivers and shall not usually go through
regular trees.

Best regards,
Krzysztof
