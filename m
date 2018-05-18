Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeERFuX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:50:23 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:51248 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750957AbeERFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:50:22 -0400
X-UUID: f0fd5c303a4a4f09a5f036b6091ac351-20180518
Message-ID: <1526622600.31853.117.camel@mhfsdcap03>
Subject: Re: Some questions about the spi mem framework
From: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        <guochun.mao@mediatek.com>, <benliang.zhao@mediatek.com>,
        <bayi.cheng@mediatek.com>, <dandan.he@mediatek.com>,
        <sean.wang@mediatek.com>, <ryder.lee@mediatek.com>,
        <xiaolei.li@mediatek.com>, <honghui.zhang@mediatek.com>
Date: Fri, 18 May 2018 13:50:00 +0800
In-Reply-To: <20180517094232.20651211@bbrezillon>
References: <1526355800.31853.45.camel@mhfsdcap03>
         <20180515172551.1adcf276@bbrezillon>   <1526472699.31853.80.camel@mhfsdcap03>
         <20180516144204.65bb20c5@bbrezillon>   <1526540304.31853.98.camel@mhfsdcap03>
         <20180517091308.387f0a70@bbrezillon>
                <1526542504.31853.106.camel@mhfsdcap03>
         <20180517094232.20651211@bbrezillon>
Content-Type: multipart/mixed; boundary="=-onIfFDsnFmBbFmGa1Ul0"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-onIfFDsnFmBbFmGa1Ul0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Boris,

On Thu, 2018-05-17 at 09:42 +0200, Boris Brezillon wrote:
> On Thu, 17 May 2018 15:35:04 +0800
> Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> 
> > On Thu, 2018-05-17 at 09:13 +0200, Boris Brezillon wrote:
> > > On Thu, 17 May 2018 14:58:24 +0800
> > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > >   
> > > > Hi Boris,
> > > > 
> > > > On Wed, 2018-05-16 at 14:42 +0200, Boris Brezillon wrote:  
> > > > > On Wed, 16 May 2018 20:11:39 +0800
> > > > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > > > >     
> > > > > > Hi Boris,
> > > > > > 
> > > > > > On Tue, 2018-05-15 at 17:25 +0200, Boris Brezillon wrote:    
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Tue, 15 May 2018 11:43:20 +0800
> > > > > > > Xiangsheng Hou <xiangsheng.hou@mediatek.com> wrote:
> > > > > > >       
> > > > > > > > Hello Boris,
> > > > > > > > 
> > > > > > > > I have seen you are working on extend the framework to generically
> > > > > > > > support spi memory devices.
> > > > > > > > And, I am working on upstream SPI Nand driver of Mediatek SPI NAND
> > > > > > > > controller based on your branch[1].      
> > > > > > > 
> > > > > > > Great!
> > > > > > >       
> > > > > > > > I have some questions need your comment.
> > > > > > > > 
> > > > > > > > 1) There is a difference between different SPI NAND Flash when using the
> > > > > > > > Quad SPI command,for example Macronix,Etron and GigaDevice, 
> > > > > > > > Quad SPI commands require the Quad Enable bit in Status Register(B0H) to
> > > > > > > > be set.
> > > > > > > > However, current spi-mem framework does not have this operation,
> > > > > > > > do you have a plan to support it?      
> > > > > > > 
> > > > > > > I added support for the QE bit in the v7 I sent just a few minutes ago
> > > > > > > [1].      
> > > > > > 
> > > > > > Ok,I have studied v7.
> > > > > >     
> > > > > > >       
> > > > > > > > 
> > > > > > > > 2) I see that current spi-mem framework doesn't support ECC,
> > > > > > > > But we need ECC, and we use Mediatek controller's HW ECC
> > > > > > > > instead of spi nand on-chip ECC,
> > > > > > > > maybe other companies also have this behavior,
> > > > > > > > So the ECC part must be implemented in controller's driver.
> > > > > > > > Will you abstract ECC interface in future?       
> > > > > > > 
> > > > > > > Well, I added support for on-die ECC in my v7 since all chips seem to
> > > > > > > provide this feature. I was initially planning on abstracting ECC
> > > > > > > engines, but I decided to go for a simpler approach and only support
> > > > > > > on-die ECC. That does not mean we shouldn't work on this "ECC engine
> > > > > > > abstraction", just that I wanted to get something out and didn't have
> > > > > > > time to spend on this topic.
> > > > > > > 
> > > > > > > I'd be happy if someone else could work on that aspect though. BTW, do
> > > > > > > you plan to use this engine [2], or is this yet another ECC engine?      
> > > > > > 
> > > > > > Yes,I plan to use this ecc engine[2].    
> > > > > 
> > > > > Cool. That probably means we'll have to move the driver one level up
> > > > > (in drivers/mtd/nand) and work on this ECC engine interface I was
> > > > > talking about.
> > > > >      
> > > > > > > > 3) You know, some nand controller need configure their registers when
> > > > > > > > getting some information(page size, spare size) of nand flash,
> > > > > > > > But the spi-mem framework doesn't has an interface for scanning NAND
> > > > > > > > flash, when controller driver initialization.      
> > > > > > > 
> > > > > > > You seem to mix 2 different things:
> > > > > > > - spi-mem: this is generic interface provided by the SPI framework to
> > > > > > >   send spi_mem_op. There's nothing NOR or NAND specific in there, and
> > > > > > >   I'd like it to stay like that as much as possible
> > > > > > > - spinand: this the spi-mem driver that is dealing with SPI NAND
> > > > > > >   devices, and this is where all the code related to SPI NAND support
> > > > > > >   should end up.
> > > > > > > 
> > > > > > > Can you tell me exactly why your SPI controller needs such a detailed
> > > > > > > description? Is it able to program/read pages or erase blocks on its
> > > > > > > own? Do you have a spec of this controller publicly available?      
> > > > > > 
> > > > > > For Mediatek SPI Nand controller,I have to configure registers for ECC
> > > > > > engine,page format and spare format according to nand information just
> > > > > > like[3] in mtk_nfc_hw_runtime_config() function.    
> > > > > 
> > > > > So it's all related to the NAND controller, nothing specific to the SPI
> > > > > controller, right?    
> > > > 
> > > > Yes,we use NAND controller rather than SPI controller.  
> > > 
> > > Sorry, I meant ECC engine, not NAND controller.  
> > 
> > It's related to ECC engine and NAND controller.
> 
> Not sure I understand what you call NAND controller. Is it a SPI NAND
> controller or the raw NAND controller available in
> drivers/mtd/nand/raw? And if it's a SPI NAND controller, does that mean
> MTK implements a NAND dedicated logic on top of its SPI controller?
> 

Just as the attachment, MTK Nand controller can support Parallel Nand
and SPI Nand via Parallel Nand interface or SPI interface,they share the
MTK ECC engine.

Best Regards,
Xiangsheng Hou


--=-onIfFDsnFmBbFmGa1Ul0
Content-Type: image/jpeg; name="MTK Nand Controller.jpg"
Content-Disposition: attachment; filename="MTK Nand Controller.jpg"
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsK
CwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQU
FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAARCAGAAhsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9U6KK
KACiiigAooooAKKKKACiiigAooooAKKKKACiiigAoopkn3WoA55fiF4ckGV1m0Yf7L0rfEDw4f8A
mM2v/fdSeCFz4P0H/rwg/wDRa1u/zq5csWRHmOe/4WB4c/6DFr/33R/wsDw5/wBBi1/77roMCjAo
90PeOf8A+FgeHP8AoMWv/fdH/CwPDn/QYtf++66DAowKPdD3jn/+FgeHP+gxa/8AfdH/AAsDw5/0
GLX/AL7roMCjAo90PeOf/wCFgeHP+gxa/wDfdH/CwPDn/QYtf++66DAowKPdD3jn/wDhYHhz/oMW
v/fdH/CwPDn/AEGLX/vuugwKMCj3Q9452T4heHI03vrVoif79b8NwlxCksTK8bruVl71S1wf8SPU
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
CiiigAooooAKKKKACiiigD//2T==


--=-onIfFDsnFmBbFmGa1Ul0--
