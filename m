Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AIpwx4/Qo76DOEQdY1QJEtsPke7eVLXUnxpkJOgXotKIcBWbQYeCPW7L4n5GQpDOcVGWxgU/axgG
ARC-Seal: i=1; a=rsa-sha256; t=1522357992; cv=none;
        d=google.com; s=arc-20160816;
        b=pDD3McIEXYLTawsr/zmZQ66kofunQ8WXSXnlgEfFJpnNNny/CCNYSeVU7oE7rdyXzi
         Mle4CNUTcyz0mTACQuIYBvvNUdt3JO1NAAXEikljZDTk1WkD/Q4qCTPhZsJJVt0zSa2m
         x0T7FfYtOqXFRcbrpRSwqgU/Lc/gDb292ZP7QFYLomyM6KF5OqpnxWA1XNjgnLTDD52g
         zUjnEvhCAcT1DYxOOG9N3MlBWI5bILoejfzuf1XtcbG7qkeqY3VHbdIZ8bafctJ8vtb8
         RDHnhtk//4/yzJUUDIqCxQogoWPN3WmstLiOBlb/CVr/ohDEAZ/ga3BNoYX6/FszDVZ4
         lWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=qw7uARoKzzQuf8IcR1fcunb8ax5iWRsLBnw/ht0WuUs=;
        b=Qld+pmHFzoRugKfJGNJFoDgvYsu/AxK1TNNwkG6Vgm60tCqiD3yELqn9rSlMr1/yMP
         qt5PAcWoJ6mw/GmFDlpmzSWjVbfOd1kvUYD7mAOMv5AvTIplEETMTpUOmK05+n+1By2T
         0LyL79A3PRk1euzULmIDGDGTFWtFsJwl7RlN0gkUNjfhnOFg+7Ya3DNkH35jfU1ICTOY
         QNg2GMO+Sl6BdO3hCirnQIvC0PZ/yiT/Eo6D7nlzLFbCncHmkP0VR0yFabgXPwe7jHp6
         9nh9tNpfAowBtKB/AhUqf8DtYosob/b3xXDdwnT+w0q1TPLOInezQOvJ9raSmlrwLd7T
         ZZVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26ACF217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
References: <1522182014-7338-1-git-send-email-richard.gong@linux.intel.com> <1522182014-7338-5-git-send-email-richard.gong@linux.intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 16:12:30 -0500
X-Gmail-Original-Message-ID: <CANk1AXTYZTdMHMPkz1+0zZ2f2FJ-rjJVUbtjjKW06ac1J5VAVQ@mail.gmail.com>
Message-ID: <CANk1AXTYZTdMHMPkz1+0zZ2f2FJ-rjJVUbtjjKW06ac1J5VAVQ@mail.gmail.com>
Subject: Re: [PATCHv3 4/7] dt-bindings: fpga: add Stratix10 SoC FPGA manager binding
To: Richard Gong <richard.gong@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Moritz Fischer <mdf@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
	Yves Vandervennet <yves.vandervennet@linux.intel.com>, Richard Gong <richard.gong@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596123756230915390?=
X-GMAIL-MSGID: =?utf-8?q?1596308054674987716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 3:20 PM,  <richard.gong@linux.intel.com> wrote:
> From: Alan Tull <atull@kernel.org>
>
> Add a Device Tree binding for the Intel Stratix10 SoC FPGA manager.
>
> Signed-off-by: Alan Tull <atull@kernel.org>
> ---
> v2: this patch is added in patch set version 2
> v3: change to put fpga_mgr node under firmware/svc node
> ---
>  .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt      | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
>
> diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> new file mode 100644
> index 0000000..be7cd96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
> @@ -0,0 +1,17 @@
> +Intel Stratix10 SoC FPGA Manager
> +
> +Required properties:
> +The fpga_mgr node has the following mandatory property, must be located under
> +firmware/svc node.
> +
> +- compatible : should contain "intel,stratix10-soc-fpga-mgr"
> +
> +Example:
> +
> +       firmware {
> +               svc {
> +                       fpga_mgr: fpga-mgr@0 {

Shouldn't have the index.  Should be:

                            fpga_mgr: fpga-mgr {

Alan

> +                               compatible = "intel,stratix10-soc-fpga-mgr";
> +                       };
> +               };
> +       };
> --
> 2.7.4
>
