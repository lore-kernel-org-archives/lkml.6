Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbeCGKEm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:04:42 -0500
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:19795
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751127AbeCGKEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:04:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robert.Richter@cavium.com;
Date: Wed, 7 Mar 2018 11:04:04 +0100
From: Robert Richter <robert.richter@cavium.com>
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        Fu Wei <fu.wei@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sbsa: use 32-bit read for WCV
Message-ID: <20180307100403.GB14432@rric.localdomain>
References: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [80.171.203.19]
X-ClientProxiedBy: AM6PR0202CA0013.eurprd02.prod.outlook.com (52.133.26.154)
 To CO2PR0701MB0999.namprd07.prod.outlook.com (10.141.248.23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872df057-9f8c-4ec1-ef94-08d58412d5a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CO2PR0701MB0999;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;3:FsZCqYDDRjy2eACCBPl+0lqIPYdbzsOQYDj+bVSNa+3cSdpicqH4yY8SKcjbgEqSUkOdoy1Jl5qicgiXn0IjNEMatOKSkdjXkQ/sOhAOwvBPtY+wWok0LnHB9LIgossIFTJ6IkfraN1+x20HMVTs0dKBthNTqcbjezd4RcZtBZ+cKuHSHwHUpQk8CFSKxMR2QkIqE8GBPM4zhB4NxouQ0r9xO6+3UKl9k3LzmVqQVh9rLlb8OLi0qN5R4DMtoz5b;25:1bJ0g+0fec5QodNRpt4ls4kynhhuwnZIdoSwJMfzp8G3HygxHwztlY6jIkKqQuh3nwtoB3OffdCXc52Gzmj78W1FhV24rgZJoL7NIiwKgCmxkr/ppXAC8dCn83iDBILvsN9wKVP8CSdWIFkmn6IJlFSDwSZHrUqhb6gSyUpiJaEzmRvmWsmc0WJoDwJSc4XRlrpyrvdvmk1ouyINIADffTMFkPAoAqp+jh7zEGUR1Rek86TjiyFWSJxeBkPy3AZtf7Z13iBa/KK+XSiCZIQ5cHwxtkiSwcT5JEZkd0WoDd+LYH7c68glzjOxMUxxDMG519ttjEi2KSvUC3wU9iecRA==;31:83CDxUr4w9vUvFOoFkig5TqdTe5ikIRQOPSfJJJLrDjMbDJ8LGD/X6oe5Puh0briCN/pVG7MKVuOAIyKWIbNaKnmMAkCCuXri5hF09c1oVWF7SuulRqIA39zYSaM/iJSyv3BvxSU5TBN4thIvfi4azfHMwc93/i783YxlNU5lGx8xJNRPn7nuDT7sT5gUbDekyxlko90MwHS5C4OhovvM8UKTWpmMuI4syMJDzTvfoA=
X-MS-TrafficTypeDiagnostic: CO2PR0701MB0999:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;20:Qufl823MQugfeXbixntvcsDSJls4wUGv6h8YBvpj5rxAPzrd8LZj/o2O/ppmSOugypYcZDrG7rnGhAD4At3GeBMnM267OJjK0EfPzxIVXkiQcrgI1kOukYB3b8cmyQ5hLlmDhsrAlyQs7/X14ucVWwvChCYaH6oglR5MlFBKHYGPnn5AO946LrkoZHvswTsW4xgDjmthOouvw1mCk5R4SsrZR83huClfQNB84H0CwuH7NElhWy7l1bGdlYOL8OGMbphtGsMqGw2sOdHR9TYh62HdZkejAreyDBm7m1OUuuqs3BKz6fF5bIABXmBRC9MMo804jd0Q3NmPCsk+NVa3so8EnHZEzi1TovyVQkG/b80eVEauW6gxqdih/P8SMI8Su+/4eNayg4cvIawyJsIe9MVmJygSDXFw0O3ED/fr9ePj9Ud7QZI1fZLfqcXRuVz71/ZCffK88QSUA4ngDEFB43s21LzEAz4zG0tpU6bO3QYGd0OqoF1lyw4utBD8Owql;4:ZxgGDGnt5Xh3Ch37V0Yg3yNw0qcznjVI36Y+6tWuziVAHdLFlWDOpKc6JhWA4OAljc5s0Z0FmKe5ZctiFFat+fglo678t7szJgjWxTIwL+KLBmVoNU1EWK7d8o1BNYAwqa61ZvIken7w9NJU1nduTAkL5uzcq6X5uapcEFYRIriRzsAAS7cr4qs1gJph/Q13w5Nk8B6tqWFCWdA/4OXq0dcNBlnX+ak+2NO4zNWWZ4hD/8aGbhuKoBO+tSEe2hTNMtKqZnu1tyuj8AWew9j83g==
X-Microsoft-Antispam-PRVS: <CO2PR0701MB09995039A79A93BEDE01172CF1D80@CO2PR0701MB0999.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR0701MB0999;BCL:0;PCL:0;RULEID:;SRVR:CO2PR0701MB0999;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(39380400002)(346002)(366004)(189003)(199004)(3846002)(23726003)(68736007)(6116002)(50466002)(1076002)(5660300001)(72206003)(478600001)(33656002)(106356001)(7736002)(229853002)(6666003)(9686003)(55016002)(2950100002)(305945005)(54906003)(66066001)(58126008)(16586007)(47776003)(105586002)(97736004)(26005)(4326008)(76176011)(33896004)(6862004)(16526019)(52116002)(7696005)(25786009)(2906002)(86362001)(81156014)(8936002)(8676002)(81166006)(316002)(386003)(6506007)(59450400001)(53546011)(6246003)(53936002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR0701MB0999;H:rric.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR0701MB0999;23:wtWLMw+y6j5hck4sqmy+uX8dUuW7A33HRAcdvd9?=
 =?us-ascii?Q?6tvFbtfyZ/cQ5Vb4xBDMjX+hd/CQ4/JdEvW/m3LZdcvVDY1COratT3FepcK4?=
 =?us-ascii?Q?CV9WP/ZNqeGvyeLLGjDkbNuVzN9rbqgqz9cw459/+E5OZUPN7skU2PyGrzyw?=
 =?us-ascii?Q?wGDC3Nw/nsB3bJKA8aUOzzZhdXqqr89ImGUW589/+30eksAzMs4iIFFS3L+Z?=
 =?us-ascii?Q?RrFhaoH89t42trK/Y9iOY/N4mvlmVWqFBKojXvPI03PMtpndMhi5/+OFL9ho?=
 =?us-ascii?Q?6NfIYHz0CGXBscVKd3B0iIrUdUnkrQcFuFANZ1fyQrEQqGN4ZLGVyeyKyMrM?=
 =?us-ascii?Q?arXYB0o+pX5rDglRCoQDFcEvL+G+NwLJR7ticjM+xp8/1B+HIPrdjEGXmAUk?=
 =?us-ascii?Q?2gZV25RLLkIChWeD2EuRFP/Hd6fGvY6ysIHDEv1zsDMHoLzi43DY3OK1S+uM?=
 =?us-ascii?Q?nSoR4pBhTQjYSo4l4MGvKsoq1sNKxmWmRJet9KhPh4b2QyRHi0MTIQGE0u7D?=
 =?us-ascii?Q?qlDLiGbXgHfWxH1LJZ70G32oYlumKNrEx6iszuFjwH0tof1ZKJy8Y0Bl34mA?=
 =?us-ascii?Q?W5kt1SCJg4wvm6uwzDb36XsjaQVk97yaILbKa/U51sSm4bJ/SIGJdqDc1lOP?=
 =?us-ascii?Q?nn22SzvTcaelaiGHVMgqTWeC+0ojdi5HH7k0iREhI9UqHce1dRmRXJ55KH8I?=
 =?us-ascii?Q?juyujpjnT356cCs/30uOYkYGPwAFsOVS16NZmZPy5YeoDcf9dlfpzkaVjHll?=
 =?us-ascii?Q?Ha/Ej/5N+/hY6aKTEyuksFru1F835kLTMRgBuyhvRIISBJ1Lg42rJWwxjBC7?=
 =?us-ascii?Q?c5m1R/8WBCWqpy1WHOF+QJgfx4Oq5rpq8jQvRS0Ga8ia3WikNHzMRmeGl3yY?=
 =?us-ascii?Q?QY9Y4a2STNnVJWYpyiIbYlAJkz6ioPmDZE8v/JJiYV1kWcmYw0c5x6FOBXE2?=
 =?us-ascii?Q?atwvJYmx0qGYNXJgERudQEEsYaypBt35oQ7CvOLJYS5uh/tJYe2jovvrh+jb?=
 =?us-ascii?Q?PslIEDqXYjOEwIFRCLPXgrTkgAj/I60RL8eb9n1I98Rh+zV2tRyxhUTZJ9yw?=
 =?us-ascii?Q?7JQfyaFGz5bQhNj0k30fpbTVkBfb4se9H76kU8zuGPbxdIwP/VYhEWMRCttx?=
 =?us-ascii?Q?m972lO+NxZQW+DAMcYtszmnN0HjBHxAQdjtPUPXDqiBW6bA+qsNz0Oh7W8ha?=
 =?us-ascii?Q?+ZLDWtabJuTDW/gtYNaT6X4WCVP8tZYq9tUCWyXFvRN0UaYwGHjvZU40aOIJ?=
 =?us-ascii?Q?0QMwzVUYpXw7VRdFOunvygJlUIaL/OXXIJxfdSOtYQxEqFbbyhMnfm23HzGd?=
 =?us-ascii?Q?x8A=3D=3D?=
X-Microsoft-Antispam-Message-Info: YoYlfvpNyZ28IA5rLpumJ3P1PMSFI/DIiGr6X9vcDY5vkTvs/Dt1svLUd1bmG9JdfZLBL38BnP+OSC86vSieC3qFUAx1ySbsedYT4osDto/MA6nTchw9AaJ+lZsd5DpIefPdzFAdMNIbjGC9VvpCdoTvEbNNFbx+945bziSc5ZLXAtFMalFscmuV1iH/pmt3
X-Microsoft-Exchange-Diagnostics: 1;CO2PR0701MB0999;6:Lto/QDPPtt+HXuQpwjnPxNzTNDSguuxlv0NIMjJ2SVGFHEw2iRX2nkQhQleflyHC4cd53smLw8GBhjnj07+SytD55WMdae1tONaI3TBlkmoybFqPdWuPu3CFYg3gObF1tagsoy4ukuF68iCuWe18aQzc4AWjh9/deqW9P+154k1bBtikhrzKPQWry1QsQ+Qw0+KXFIC4dajpGd7mnPvAoS7Pdi3FoxkZ5+A12LVkkCr/itWnfgogmjbSmMsjGTHGZML2TeuBWxcrETFJdfxuslztSq3s2HUyeGZoziwJvEOqSUsoXh4K9yGAQKhjvIRefdT57b/7bic7sgglnM+UtRis4Dd78FAs+w9cFl5qn8Y=;5:YrQf1GjSjexMMz8kqHye12HTNqKQET0rwYn8QY3dt4niRc5IP7gUpniKvExODn1QsuQLZdQunwDF8FBfyOMwiRT3zBJ9R0zg7Cn7X0rT1Ksy1X2yR69ds+EZdvJ9pOk5tODa8RiVGz2olJ7y6Atl4Zh+K4hV8Ow3N+bJifHvoLI=;24:db3Jhn/kVw/m84uig3Q4gOu9M086jJwzS7jSqqkwHZ/cSALVtwzGiEwzhOT5aJtsqyWMKUl8ayPMj4dFRdMzO47O97YLClqgFvJhIqjzq+g=;7:TQkh2Ni7MQjPasZtlCb/qIhBDjXlaScAJBKhxx9SJM+jlfQMPRPas1W//oimcst5bFgACpgX/6HZq5y5/+o8VSMLuD6S0kV+h8QdXgxKdLcJnpgvfthmjCgu5BoGBlRpjZpA/we6mnzQJGFJAwmOZy5BWe0Gmygk8vAQBd0PhEB3n6WI+R5cwG+RxMB5xtRiexmtPM1uNNH26cAyJ9VkEYkrjmLzma8+kCsr7nHXMxyk+PdB76Lcl2cz1eFvl++i
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 10:04:35.6608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872df057-9f8c-4ec1-ef94-08d58412d5a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR0701MB0999
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.18 02:52:20, Jayachandran C wrote:
> According to SBSA spec v3.1 section 5.3:
>   All registers are 32 bits in size and should be accessed using
>   32-bit reads and writes. If an access size other than 32 bits
>   is used then the results are IMPLEMENTATION DEFINED.
>   [...]
>   The Generic Watchdog is little-endian
>
> The current code uses readq to read the watchdog compare register
> which does a 64-bit access. This fails on ThunderX2 which does not
> implement 64-bit access to this register.
>
> Fix this by using lo_hi_readq() that does two 32-bit reads.
>
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>

Reviewed-by: Robert Richter <rrichter@cavium.com>

I have looked into the non-atomic use of the register access and it
looks sane as the WCV register is only incremented by hardware. There
is no concurrent (write) access from the kernel.

-Robert
