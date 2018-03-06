Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELsecM1q/SKQVU4nTFHGDJReRKghZY5Cga6RfnaFccJT1eajkRDoQsFzPybuy48bXSecGpqn
ARC-Seal: i=1; a=rsa-sha256; t=1520345362; cv=none;
        d=google.com; s=arc-20160816;
        b=0kMlyS4Td3Svrv8tUG4yYXIk8tTi/hZhjYJSfFt3jP4E6OBAsD1gvpnDlfuK4IIL0o
         9sBOSNSFV1NdSJYkWCbB6V+iQ3+izfM1RDc+/gUx+iQEmftCxz9PTRCg6L8W3/6pgGvc
         Pib7K17Nvmt4COKba/+z55zbu6CXh7Evqr1XFUwiVcDdNjPaDP8yjVUgzg+ofGf2N7Q2
         ySnX8SqXMdyw4ZCLHt/5EDim+IFGWTbnOFYA20fDlOBgoNIaeG42hXarMIG72zK/ysWb
         bzXPvOaoRLBLsJPicapkTHRC+JI+B6mAc04vSZUoKKtsvDMI34hSwNCSkXZOkoSrmRTQ
         1NfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ziI//g/NRcnLr5K8Uht3I6Wr17o/ceMrTSQiepFUEm8=;
        b=QZubMKi3Kq/2tI8FEzb796+coWQqrw/P37xgz1qoSVw+AbPaaeWjNNuYXmshLeVOTp
         YgToftG6jG35rdWvmHzPvfb4Aggo27IQKgnQB/68P1mvtzs8flyZx1awyRlfiuIWDGIY
         5cRoNemo9k+360sgyVOcBlU5VwWFT4/iZbt7Z94raS3OGmCf7nU/9JdmWAl/wUiLUgbQ
         vkzwuOq8eoA8RlMlqGwQhGeop98cx7xOD0TtobJauS7/kXcpAEs1zy5mYgkIRH7oofHr
         uzhHqirpXmOFysTJYVSFGygxHS0kD7fIKbEd1AVeGiRboS5eI+3XNiP1RNyjowGZ48pw
         J4iw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external vbus
 supply property
To: Rob Herring <robh@kernel.org>, Amelie Delaunay <amelie.delaunay@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Tony Prisk <linux@prisktech.co.nz>,
 Alan Stern <stern@rowland.harvard.edu>, Roger Quadros <rogerq@ti.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
 <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
 <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ae4c741e-d5aa-4a8c-4029-1dff6bef2cdd@arm.com>
Date: Tue, 6 Mar 2018 14:09:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306015743.uazy4e5quil2ijy2@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593728540425341885?=
X-GMAIL-MSGID: =?utf-8?q?1594197658447820257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/03/18 01:57, Rob Herring wrote:
> On Thu, Mar 01, 2018 at 10:51:38AM +0100, Amelie Delaunay wrote:
>> On some boards, especially when vbus supply requires large current,
>> and the charge pump on the PHY isn't enough, an external vbus power switch
>> per port may be used.
>> Add portN_vbus-supply property to usb-ehci bindings. As the number of ports
>> depends on the ehci controller, and the port on which an external vbus
>> supply depends on the platform, <portN> is used to make it generic.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 3efde12..cd576db 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -19,6 +19,7 @@ Optional properties:
>>    - phys : phandle + phy specifier pair
>>    - phy-names : "usb"
>>    - resets : phandle + reset specifier pair
>> + - portN_vbus-supply : phandle of regulator supplying vbus for port N
> 
> Just make this an array with the index being the port (and drop
> "portN_").

Does that still work if there is an external supply for port 1 but none 
for port 0? I believe that was brought up as a possibility before.

Robin.
